require 'ffi'

require 'ffi-magic/version'

class Magic
  extend FFI::Library
  ffi_lib ['magic', 'libmagic.so.1']

  attach_function :magic_open, [:int], :pointer
  attach_function :magic_error, [:pointer], :string
  attach_function :magic_load, [:pointer, :string], :int
  attach_function :magic_file, [:pointer, :string], :string
  attach_function :magic_setflags, [:pointer, :int], :void
  attach_function :magic_buffer, [:pointer, :string, :int], :string
  attach_function :magic_check, [:pointer, :string], :int
  attach_function :magic_compile, [:pointer, :string], :int
  attach_function :magic_close, [:pointer], :void

  NONE              = 0x000000
  DEBUG             = 0x000001
  SYMLINK           = 0x000002
  COMPRESS          = 0x000004
  DEVICES           = 0x000008
  MIME_TYPE         = 0x000010
  CONTINUE          = 0x000020
  CHECK             = 0x000040
  PRESERVE_ATIME    = 0x000080
  RAW               = 0x000100
  ERROR             = 0x000200
  MIME_ENCODING     = 0x000400
  MIME              = MIME_TYPE | MIME_ENCODING
  APPLE             = 0x000800
  NO_CHECK_COMPRESS = 0x001000
  NO_CHECK_TAR      = 0x002000
  NO_CHECK_SOFT     = 0x004000
  NO_CHECK_APPTYPE  = 0x008000
  NO_CHECK_ELF      = 0x010000
  NO_CHECK_TEXT     = 0x020000
  NO_CHECK_CDF      = 0x040000
  NO_CHECK_TOKENS   = 0x100000
  NO_CHECK_ENCODING = 0x200000

  Error = Class.new(StandardError)

  def self.compile(path)
    cookie = magic_open(NONE)

    unless magic_compile(cookie, path) == 0
      raise Error, "failed compile: #{magic_error(cookie)}"
    end

    magic_close(cookie)

    true
  end

  def initialize(flags = NONE, path = nil)
    @flags = flags
    @path = path

    unless @cookie = magic_open(@flags)
      raise Error, "failed to initialize magic cookie"
    end

    if magic_load(@cookie, @path) != 0
      raise Error, "failed to load database: #{magic_error(@cookie)}"
    end

    begin
      ObjectSpace.define_finalizer(self){ close }
    rescue
    end
  end

  def file(path)
    unless msg = magic_file(@cookie, path)
      raise Error, "failed lookup: #{magic_error(@cookie)}"
    end

    msg
  end

  def buffer(input)
    input.force_encoding(Encoding::BINARY)
    magic_buffer(@cookie, input, input.bytesize.to_s)
  end

  def flags=(flags)
    @flags = flags
    magic_setflags(@cookie, flags)
  end

  def valid?(path = nil)
    magic_check(@cookie, path) == 0
  end

  def load
    unless magic_load(@cookie, path) == 0
      raise Error, "failed load: #{magic_error(@cookie)}"
    end
  end

  def close
    magic_close(@cookie) if @cookie
    @cookie = nil
  end
end
