# Ruby FFI bindings for libmagic

## Usage

```ruby
>> require 'ffi-magic'
=> true
>> magic = Magic.new
=> #<Magic:0x000000012e5ff8 @flags=0, @path=nil, @cookie=#<FFI::Pointer address=0x000000017e38b0>>
>> magic.file('spec/magic.png')
=> "PNG image data, 100 x 67, 8-bit/color RGB, non-interlaced"
>> magic.flags = Magic::MIME_TYPE
=> 16
>> magic.file('spec/magic.png')
=> "image/png"
```

### Getting the MIME Type

```ruby
magic = Magic.new(Magic::MIME)
=> #<Magic:0x00000000a3cc80 @flags=1040, @path=nil, @cookie=#<FFI::Pointer address=0x00000000df7190>>
>> magic.file('spec/magic.png')
>> => "image/png; charset=binary"
```
