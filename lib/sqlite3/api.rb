# encoding: UTF-8

module SQLite3
  module API
    extend ::FFI::Library

    # prefer spatialite, a version of sqlite extended to support spatial data conforming
    # to OpenGis specifications. http://www.gaia-gis.it/spatialite/
    $sqlite3_load_order ||= [
            Dir['/{opt,usr}/{,local/}lib{,64}/libspatialite.{dylib,so*}'],
            'spatialite',
            Dir['/{opt,usr}/{,local/}lib{,64}/libsqlite3.{dylib,so*}'],
            'sqlite3'
    ].flatten

    ffi_lib($sqlite3_load_order)

    def sqlite3_callback
      callback(:sqlite3_callback, [ :pointer, :int, :pointer, :pointer ], :int)
    end

    module_function :sqlite3_callback

    def sqlite3_destructor_type
      callback(:sqlite3_destructor_type, [ :pointer ], :void)
    end

    module_function :sqlite3_destructor_type

    attach_function :sqlite3_aggregate_context,       [ :pointer, :int ], :pointer
    attach_function :sqlite3_aggregate_count,         [ :pointer ], :int
    attach_function :sqlite3_auto_extension,          [ callback([  ], :void) ], :int
    attach_function :sqlite3_backup_finish,           [ :pointer ], :int
    attach_function :sqlite3_backup_init,             [ :pointer, :string, :pointer, :string ], :pointer
    attach_function :sqlite3_backup_pagecount,        [ :pointer ], :int
    attach_function :sqlite3_backup_remaining,        [ :pointer ], :int
    attach_function :sqlite3_backup_step,             [ :pointer, :int ], :int
    attach_function :sqlite3_bind_blob,               [ :pointer, :int, :pointer, :int, callback([ :pointer ], :void) ], :int
    attach_function :sqlite3_bind_double,             [ :pointer, :int, :double ], :int
    attach_function :sqlite3_bind_int,                [ :pointer, :int, :int ], :int
    attach_function :sqlite3_bind_int64,              [ :pointer, :int, :int64 ], :int
    attach_function :sqlite3_bind_null,               [ :pointer, :int ], :int
    attach_function :sqlite3_bind_parameter_count,    [ :pointer ], :int
    attach_function :sqlite3_bind_parameter_index,    [ :pointer, :string ], :int
    attach_function :sqlite3_bind_parameter_name,     [ :pointer, :int ], :string
    attach_function :sqlite3_bind_text,               [ :pointer, :int, :string, :int, callback([ :pointer ], :void) ], :int
    attach_function :sqlite3_bind_text16,             [ :pointer, :int, :pointer, :int, callback([ :pointer ], :void) ], :int
    attach_function :sqlite3_bind_value,              [ :pointer, :int, :pointer ], :int
    attach_function :sqlite3_bind_zeroblob,           [ :pointer, :int, :int ], :int
    attach_function :sqlite3_blob_bytes,              [ :pointer ], :int
    attach_function :sqlite3_blob_close,              [ :pointer ], :int
    attach_function :sqlite3_blob_open,               [ :pointer, :string, :string, :string, :int64, :int, :pointer ], :int
    attach_function :sqlite3_blob_read,               [ :pointer, :pointer, :int, :int ], :int
    attach_function :sqlite3_blob_write,              [ :pointer, :pointer, :int, :int ], :int
    attach_function :sqlite3_busy_handler,            [ :pointer, callback([ :pointer, :int ], :int), :pointer ], :int
    attach_function :sqlite3_busy_timeout,            [ :pointer, :int ], :int
    attach_function :sqlite3_changes,                 [ :pointer ], :int
    attach_function :sqlite3_clear_bindings,          [ :pointer ], :int
    attach_function :sqlite3_close,                   [ :pointer ], :int
    attach_function :sqlite3_collation_needed,        [ :pointer, :pointer, callback([ :pointer, :pointer, :int, :string ], :void) ], :int
    attach_function :sqlite3_collation_needed16,      [ :pointer, :pointer, callback([ :pointer, :pointer, :int, :pointer ], :void) ], :int
    attach_function :sqlite3_column_blob,             [ :pointer, :int ], :pointer
    attach_function :sqlite3_column_bytes,            [ :pointer, :int ], :int
    attach_function :sqlite3_column_bytes16,          [ :pointer, :int ], :int
    attach_function :sqlite3_column_count,            [ :pointer ], :int
    attach_function :sqlite3_column_decltype,         [ :pointer, :int ], :string
    attach_function :sqlite3_column_decltype16,       [ :pointer, :int ], :pointer
    attach_function :sqlite3_column_double,           [ :pointer, :int ], :double
    attach_function :sqlite3_column_int,              [ :pointer, :int ], :int
    attach_function :sqlite3_column_int64,            [ :pointer, :int ], :int64
    attach_function :sqlite3_column_name,             [ :pointer, :int ], :string
    attach_function :sqlite3_column_name16,           [ :pointer, :int ], :pointer
    attach_function :sqlite3_column_text,             [ :pointer, :int ], :string
    attach_function :sqlite3_column_text16,           [ :pointer, :int ], :pointer
    attach_function :sqlite3_column_type,             [ :pointer, :int ], :int
    attach_function :sqlite3_column_value,            [ :pointer, :int ], :pointer
    attach_function :sqlite3_commit_hook,             [ :pointer, callback([ :pointer ], :int), :pointer ], :pointer
    attach_function :sqlite3_complete,                [ :string ], :int
    attach_function :sqlite3_complete16,              [ :pointer ], :int
    attach_function :sqlite3_config,                  [ :int, :varargs ], :int
    attach_function :sqlite3_context_db_handle,       [ :pointer ], :pointer
    attach_function :sqlite3_create_collation,        [ :pointer, :string, :int, :pointer, callback([ :pointer, :int, :pointer, :int, :pointer ], :int) ], :int
    attach_function :sqlite3_create_collation16,      [ :pointer, :pointer, :int, :pointer, callback([ :pointer, :int, :pointer, :int, :pointer ], :int) ], :int
    attach_function :sqlite3_create_collation_v2,     [ :pointer, :string, :int, :pointer, callback([ :pointer, :int, :pointer, :int, :pointer ], :int), callback([ :pointer ], :void) ], :int
    attach_function :sqlite3_create_function,         [ :pointer, :string, :int, :int, :pointer, callback([ :pointer, :int, :pointer ], :void), callback([ :pointer, :int, :pointer ], :void), callback([ :pointer ], :void) ], :int
    attach_function :sqlite3_create_function16,       [ :pointer, :pointer, :int, :int, :pointer, callback([ :pointer, :int, :pointer ], :void), callback([ :pointer, :int, :pointer ], :void), callback([ :pointer ], :void) ], :int
    attach_function :sqlite3_create_module,           [ :pointer, :string, :pointer, :pointer ], :int
    attach_function :sqlite3_create_module_v2,        [ :pointer, :string, :pointer, :pointer, callback([ :pointer ], :void) ], :int
    attach_function :sqlite3_data_count,              [ :pointer ], :int
    attach_function :sqlite3_db_config,               [ :pointer, :int, :varargs ], :int
    attach_function :sqlite3_db_handle,               [ :pointer ], :pointer
    attach_function :sqlite3_db_mutex,                [ :pointer ], :pointer
    attach_function :sqlite3_db_status,               [ :pointer, :int, :pointer, :pointer, :int ], :int
    attach_function :sqlite3_declare_vtab,            [ :pointer, :string ], :int
    attach_function :sqlite3_enable_shared_cache,     [ :int ], :int
    attach_function :sqlite3_errcode,                 [ :pointer ], :int
    attach_function :sqlite3_errmsg,                  [ :pointer ], :string
    attach_function :sqlite3_errmsg16,                [ :pointer ], :pointer
    attach_function :sqlite3_exec,                    [ :pointer, :string, callback([ :pointer, :int, :pointer, :pointer ], :int), :pointer, :pointer ], :int
    attach_function :sqlite3_expired,                 [ :pointer ], :int
    attach_function :sqlite3_extended_errcode,        [ :pointer ], :int
    attach_function :sqlite3_extended_result_codes,   [ :pointer, :int ], :int
    attach_function :sqlite3_file_control,            [ :pointer, :string, :int, :pointer ], :int
    attach_function :sqlite3_finalize,                [ :pointer ], :int
    attach_function :sqlite3_free,                    [ :pointer ], :void
    attach_function :sqlite3_free_table,              [ :pointer ], :void
    attach_function :sqlite3_get_autocommit,          [ :pointer ], :int
    attach_function :sqlite3_get_auxdata,             [ :pointer, :int ], :pointer
    attach_function :sqlite3_get_table,               [ :pointer, :string, :pointer, :pointer, :pointer, :pointer ], :int
    attach_function :sqlite3_global_recover,          [  ], :int
    attach_function :sqlite3_initialize,              [  ], :int
    attach_function :sqlite3_interrupt,               [ :pointer ], :void
    attach_function :sqlite3_last_insert_rowid,       [:pointer], :int64
    attach_function :sqlite3_libversion,              [  ], :string
    attach_function :sqlite3_libversion_number,       [  ], :int
    attach_function :sqlite3_limit,                   [ :pointer, :int, :int ], :int
    attach_function :sqlite3_malloc,                  [ :int ], :pointer
    attach_function :sqlite3_memory_alarm,            [ callback([ :pointer, :int64, :int ], :void), :pointer, :int64 ], :int
    attach_function :sqlite3_memory_highwater,        [ :int ], :int64
    attach_function :sqlite3_memory_used,             [  ], :int64
    attach_function :sqlite3_mprintf,                 [ :string, :varargs ], :string
    attach_function :sqlite3_mutex_alloc,             [ :int ], :pointer
    attach_function :sqlite3_mutex_enter,             [ :pointer ], :void
    attach_function :sqlite3_mutex_free,              [ :pointer ], :void
    attach_function :sqlite3_mutex_leave,             [ :pointer ], :void
    attach_function :sqlite3_mutex_try,               [ :pointer ], :int
    attach_function :sqlite3_next_stmt,               [ :pointer, :pointer ], :pointer
    attach_function :sqlite3_open,                    [ :string, :pointer ], :int
    attach_function :sqlite3_open16,                  [ :pointer, :pointer ], :int
    attach_function :sqlite3_open_v2,                 [ :string, :pointer, :int, :string ], :int
    attach_function :sqlite3_os_end,                  [  ], :int
    attach_function :sqlite3_os_init,                 [  ], :int
    attach_function :sqlite3_overload_function,       [ :pointer, :string, :int ], :int
    attach_function :sqlite3_prepare,                 [ :pointer, :string, :int, :pointer, :pointer ], :int
    attach_function :sqlite3_prepare16,               [ :pointer, :pointer, :int, :pointer, :pointer ], :int
    attach_function :sqlite3_prepare16_v2,            [ :pointer, :pointer, :int, :pointer, :pointer ], :int
    attach_function :sqlite3_prepare_v2,              [ :pointer, :string, :int, :pointer, :pointer ], :int
    attach_function :sqlite3_profile,                 [ :pointer, callback([ :pointer, :string, :uint64 ], :void), :pointer ], :pointer
    attach_function :sqlite3_progress_handler,        [ :pointer, :int, callback([ :pointer ], :int), :pointer ], :void
    attach_function :sqlite3_randomness,              [ :int, :pointer ], :void
    attach_function :sqlite3_realloc,                 [ :pointer, :int ], :pointer
    attach_function :sqlite3_release_memory,          [ :int ], :int
    attach_function :sqlite3_reset,                   [ :pointer ], :int
    attach_function :sqlite3_reset_auto_extension,    [  ], :void
    attach_function :sqlite3_result_blob,             [ :pointer, :pointer, :int, callback([ :pointer ], :void) ], :void
    attach_function :sqlite3_result_double,           [ :pointer, :double ], :void
    attach_function :sqlite3_result_error,            [ :pointer, :string, :int ], :void
    attach_function :sqlite3_result_error16,          [ :pointer, :pointer, :int ], :void
    attach_function :sqlite3_result_error_code,       [ :pointer, :int ], :void
    attach_function :sqlite3_result_error_nomem,      [ :pointer ], :void
    attach_function :sqlite3_result_error_toobig,     [ :pointer ], :void
    attach_function :sqlite3_result_int,              [ :pointer, :int ], :void
    attach_function :sqlite3_result_int64,            [ :pointer, :int64 ], :void
    attach_function :sqlite3_result_null,             [ :pointer ], :void
    attach_function :sqlite3_result_text,             [ :pointer, :string, :int, callback([ :pointer ], :void) ], :void
    attach_function :sqlite3_result_text16,           [ :pointer, :pointer, :int, callback([ :pointer ], :void) ], :void
    attach_function :sqlite3_result_text16be,         [ :pointer, :pointer, :int, callback([ :pointer ], :void) ], :void
    attach_function :sqlite3_result_text16le,         [ :pointer, :pointer, :int, callback([ :pointer ], :void) ], :void
    attach_function :sqlite3_result_value,            [ :pointer, :pointer ], :void
    attach_function :sqlite3_result_zeroblob,         [ :pointer, :int ], :void
    attach_function :sqlite3_rollback_hook,           [ :pointer, callback([ :pointer ], :void), :pointer ], :pointer
    attach_function :sqlite3_set_authorizer,          [ :pointer, callback([ :pointer, :int, :string, :string, :string, :string ], :int), :pointer ], :int
    attach_function :sqlite3_set_auxdata,             [ :pointer, :int, :pointer, callback([ :pointer ], :void) ], :void
    attach_function :sqlite3_shutdown,                [  ], :int
    attach_function :sqlite3_sleep,                   [ :int ], :int
    attach_function :sqlite3_snprintf,                [ :int, :string, :string, :varargs ], :string
    attach_function :sqlite3_soft_heap_limit,         [ :int ], :void
    attach_function :sqlite3_sql,                     [ :pointer ], :string
    attach_function :sqlite3_status,                  [ :int, :pointer, :pointer, :int ], :int
    attach_function :sqlite3_step,                    [ :pointer ], :int
    attach_function :sqlite3_stmt_status,             [ :pointer, :int, :int ], :int
    attach_function :sqlite3_test_control,            [ :int, :varargs ], :int
    attach_function :sqlite3_thread_cleanup,          [  ], :void
    attach_function :sqlite3_threadsafe,              [  ], :int
    attach_function :sqlite3_total_changes,           [ :pointer ], :int
    attach_function :sqlite3_trace,                   [ :pointer, callback([ :pointer, :string ], :void), :pointer ], :pointer
    attach_function :sqlite3_transfer_bindings,       [ :pointer, :pointer ], :int
    attach_function :sqlite3_update_hook,             [ :pointer, callback([ :pointer, :int, :string, :string, :int64 ], :void), :pointer ], :pointer
    attach_function :sqlite3_user_data,               [ :pointer ], :pointer
    attach_function :sqlite3_value_blob,              [ :pointer ], :pointer
    attach_function :sqlite3_value_bytes,             [ :pointer ], :int
    attach_function :sqlite3_value_bytes16,           [ :pointer ], :int
    attach_function :sqlite3_value_double,            [ :pointer ], :double
    attach_function :sqlite3_value_int,               [ :pointer ], :int
    attach_function :sqlite3_value_int64,             [ :pointer ], :int64
    attach_function :sqlite3_value_numeric_type,      [ :pointer ], :int
    attach_function :sqlite3_value_text,              [ :pointer ], :pointer
    attach_function :sqlite3_value_text16,            [ :pointer ], :pointer
    attach_function :sqlite3_value_text16be,          [ :pointer ], :pointer
    attach_function :sqlite3_value_text16le,          [ :pointer ], :pointer
    attach_function :sqlite3_value_type,              [ :pointer ], :int
    attach_function :sqlite3_vfs_find,                [ :string ], :pointer
    attach_function :sqlite3_vfs_register,            [ :pointer, :int ], :int
    attach_function :sqlite3_vfs_unregister,          [ :pointer ], :int

    begin
      attach_function :sqlite3_enable_load_extension, [:pointer, :int], :int
      attach_function :sqlite3_load_extension, [ :pointer, :string, :string, :pointer ], :int

      EXTENSION_SUPPORT = true
    rescue ::FFI::NotFoundError
      EXTENSION_SUPPORT = false
    end

    begin
      attach_function :spatialite_init, [:int], :int
      self.spatialite_init(1)

      SPATIALITE_SUPPORT = true
    rescue ::FFI::NotFoundError
      SPATIALITE_SUPPORT = false
    end
  end
end
