RSpec.describe 'Version' do
  it 'is 0 for empty arguments' do
    v = Version.new('')
    expect(v).to eq '0'

    v = Version.new
    expect(v).to eq '0'
  end

  it 'trows exception on wrong version' do
    expect { Version.new('.3') }.to raise_error(
      ArgumentError,
      'Invalid version string \'.3\''
    )
    expect { Version.new('0..3') }.to raise_error(
      ArgumentError,
      'Invalid version string \'0..3\''
    )
  end

  it 'initializes with string' do
    expect(Version.new('1')).to eq '1'
    expect(Version.new('1.1')).to eq '1.1'
    expect(Version.new('1.1.1')).to eq '1.1.1'
    expect(Version.new('1.1.1.10')).to eq '1.1.1.10'
  end

  it 'initializes with version instance' do
    v = Version.new('1')
    expect(Version.new(v)).to eq '1'

    v = Version.new('1.1')
    expect(Version.new(v)).to eq '1.1'

    v = Version.new('1.1.1')
    expect(Version.new(v)).to eq '1.1.1'

    v = Version.new('1.1.1.10')
    expect(Version.new(v)).to eq '1.1.1.10'
  end

  it 'handles comparasions with 0' do
    expect(Version.new('1.1.0') == Version.new('1.1')).to eq true
    expect(Version.new('0.1') == Version.new('1')).to eq false
  end

  it 'can compare' do
    expect(Version.new('1.2.3') < Version.new('1.3.1')).to eq true
    expect(Version.new('5') > Version.new('2')).to eq true
    expect(Version.new('3.4.1') >= Version.new('3.4')).to eq true
    expect(Version.new('3.4.1') <= Version.new('3.4')).to eq false
    expect(Version.new('3.4.1') == Version.new('3.4')).to eq false

    expect(Version.new('3.4.1') <=> Version.new('3.4')).to eq 1
  end

  it 'can compare with different number of components' do
    expect(Version.new('1.2.3') < Version.new('1.3')).to eq true
    expect(Version.new('7') > Version.new('7.0.8')).to eq false
  end

  it 'converts to string' do
    expect(Version.new('1.1.0').to_s).to eq '1.1'
    expect(Version.new('11').to_s).to eq '11'
    expect(Version.new('15.0.4.0.3').to_s).to eq '15.0.4.0.3'
    expect(Version.new('15.0.4.0').to_s).to eq '15.0.4'
  end

  it 'returns its components' do
    expect(Version.new('1.3.5').components).to eq [1, 3, 5]
    expect(Version.new('1.3.5.0.0').components).to eq [1, 3, 5]
    expect(Version.new('1.3.5.0.0').components(1)).to eq [1]
    expect(Version.new('1.3.5.0.0').components(2)).to eq [1, 3]
    expect(Version.new('1.3.5.0.0').components(3)).to eq [1, 3, 5]
    expect(Version.new('1.3.5.0.0').components(7)).to eq [1, 3, 5, 0, 0, 0, 0]
  end

  it 'compponents doesn\'t change the instance' do
    v = Version.new('1.3.5.0.0')
    expect(v.components(7)).to eq [1, 3, 5, 0, 0, 0, 0]
    expect(v.to_s).to eq '1.3.5'
  end

  it 'checks if a range contains element' do
    expect(Version::Range.new(Version.new('1'), Version.new('2'))
      .include?(Version.new('1.5'))
          ).to eq true

    expect(Version::Range.new('1.3', '2.5.4')
      .include?(Version.new('1.2'))
          ).to eq false
  end

  it 'generates all versions in a range' do
    expect(Version::Range.new(Version.new('1.1.0'), Version.new('1.2.2')).to_a)
    .to eq [
      '1.1', '1.1.1', '1.1.2', '1.1.3',
      '1.1.4', '1.1.5', '1.1.6', '1.1.7',
      '1.1.8', '1.1.9', '1.2', '1.2.1'
    ]

    expect(Version::Range.new(Version.new('1.1'), Version.new('1.2')).to_a)
    .to eq [
      '1.1', '1.1.1', '1.1.2', '1.1.3',
      '1.1.4', '1.1.5', '1.1.6', '1.1.7',
      '1.1.8', '1.1.9'
    ]
  end
end