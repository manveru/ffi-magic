require 'bacon'
Bacon.summary_on_exit

require_relative '../lib/ffi-magic'

describe 'Magic' do
  @m = Magic.new

  file = File.expand_path('../magic.png', __FILE__)

  should 'recognize file' do
    @m.flags = Magic::NONE
    @m.file(file).should == "PNG image data, 100 x 67, 8-bit/color RGB, non-interlaced"
  end

  should 'return MIME' do
    @m.flags = Magic::MIME
    @m.file(file).should == "image/png; charset=binary"
  end

  should 'buffer' do
    @m.flags = Magic::NONE
    @m.buffer(File.read(file)).should == "PNG image data, 100 x 67, 8-bit/color RGB, non-interlaced"
  end

  should 'buffer MIME' do
    @m.flags = Magic::MIME
    @m.buffer(File.read(file)).should == "image/png; charset=binary"
  end

  should 'have a valid database' do
    @m.should.be.valid
  end
end
