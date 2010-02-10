# encoding: UTF-8

module SQLite3

  class Exception < ::StandardError
    @code = 0

    # The numeric error code that this exception represents.
    def self.code
      @code
    end

    # A convenience for accessing the error code for this exception.
    def code
      self.class.code
    end
  end

  SQLException                = Class.new(Exception)
  InternalException           = Class.new(Exception)
  PermissionException         = Class.new(Exception)
  AbortException              = Class.new(Exception)
  BusyException               = Class.new(Exception)
  LockedException             = Class.new(Exception)
  MemoryException             = Class.new(Exception)
  ReadOnlyException           = Class.new(Exception)
  InterruptException          = Class.new(Exception)
  IOException                 = Class.new(Exception)
  CorruptException            = Class.new(Exception)
  NotFoundException           = Class.new(Exception)
  FullException               = Class.new(Exception)
  CantOpenException           = Class.new(Exception)
  ProtocolException           = Class.new(Exception)
  EmptyException              = Class.new(Exception)
  SchemaChangedException      = Class.new(Exception)
  TooBigException             = Class.new(Exception)
  ConstraintException         = Class.new(Exception)
  MismatchException           = Class.new(Exception)
  MisuseException             = Class.new(Exception)
  UnsupportedException        = Class.new(Exception)
  AuthorizationException      = Class.new(Exception)
  FormatException             = Class.new(Exception)
  RangeException              = Class.new(Exception)
  NotADatabaseException       = Class.new(Exception)

  EXCEPTIONS =
          [
                  nil, SQLException, InternalException,
                  PermissionException, AbortException, BusyException,
                  LockedException, MemoryException, ReadOnlyException,
                  InterruptException, IOException, CorruptException,
                  NotFoundException, FullException, CantOpenException,
                  ProtocolException, EmptyException, SchemaChangedException,
                  TooBigException, ConstraintException, MismatchException,
                  MisuseException, UnsupportedException, AuthorizationException,
                  FormatException, RangeException, NotADatabaseException
          ].each_with_index { |e, i| e.instance_variable_set(:@code, i ) if e }

  module Error
    def check( result, db=nil, msg=nil )
      unless result == Constants::ErrorCode::OK
        msg = ( msg ? msg + ": " : "" ) + db.errmsg if db
        raise(( EXCEPTIONS[result] || SQLite3::Exception ), msg)
      end
    end

    module_function :check
  end

end
