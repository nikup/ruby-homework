class CommandParser
  def initialize(command_name)
    @arguments = []
    @options = []
    @parameter_options = []
    @command_name = command_name
  end

  def argument(arg, &block)
    @arguments.push({name: arg, block: block})
  end

  def option(short, long, description, &block)
    @options.push([short, long, description, block])
  end

  def option_with_parameter(short, long, description, parameter_name, &block)
    @parameter_options.push([short, long, description, block, parameter_name])
  end

  def parse(command_runner, argv)
    opt = argv.select { |a| a.start_with?("-") }
    arg = argv - opt

    handle_arguments(command_runner, arg)
    handle_options(command_runner, opt)
    handle_options_with_parameter(command_runner, opt)
  end

  def handle_arguments(command_runner, arg)
    arg.each_with_index do |e, i|
      @arguments[i][:block].call command_runner, e
    end
  end

  def handle_options(command_runner, opt)
    opt.each_with_index do |e|
      o = @options.find { |c| (e == '-' + c[0]) || (e == '--' + c[1] ) }
      o[3].call command_runner, true if o
    end
  end

  def handle_options_with_parameter(command_runner, opt)
    opt.each_with_index do |e|
      o = @parameter_options.find do |c| 
        e.start_with?('-' + c[0]) || e.start_with?('--' + c[1]) 
      end
      if o
        parameter = e.split('=')[1] || e.sub('-' + o[0], '')
        o[3].call command_runner, parameter
      end
    end
  end

  def help
    help_text = "Usage: " + @command_name
    @arguments.each { |a| help_text = help_text + " [" + a[:name] + "]" }
    @options.each do |o| 
      help_text = help_text + "\n    -" + o[0] + ", --" + o[1] + " " + o[2]
    end
    @parameter_options.each do |o| 
      help_text = help_text + "\n    -" + o[0] +
                  ", --" + o[1] + "=" + o[4] + " " + o[2]
    end

    help_text
  end
end