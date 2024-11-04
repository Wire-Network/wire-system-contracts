(module
  (type (;0;) (func (param i32 i64 i64 i64)))
  (type (;1;) (func (param i32 i64 i64 i32)))
  (type (;2;) (func (param i32)))
  (type (;3;) (func))
  (type (;4;) (func (param i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;5;) (func (param i64 i64 i32 i32 i32 i32 i64) (result i32)))
  (type (;6;) (func (result i32)))
  (type (;7;) (func (param i32 i32) (result i32)))
  (type (;8;) (func (result i64)))
  (type (;9;) (func (param i32 i32)))
  (type (;10;) (func (param i32 i32 i32) (result i32)))
  (type (;11;) (func (param i64)))
  (type (;12;) (func (param i64 i64 i64 i64) (result i32)))
  (type (;13;) (func (param i64 i64)))
  (type (;14;) (func (param i32 i64 i32 i32)))
  (type (;15;) (func (param i32 i64 i32 i32 i32)))
  (type (;16;) (func (param i64 i64 i64 i64 i32 i32) (result i32)))
  (type (;17;) (func (param i32 i32 i32 i32)))
  (type (;18;) (func (param i32 i64 i32) (result i32)))
  (type (;19;) (func (param i32 i32 i64 i32)))
  (type (;20;) (func (param i64 i64 i64)))
  (type (;21;) (func (param i32) (result i32)))
  (import "env" "check_transaction_authorization" (func (;0;) (type 4)))
  (import "env" "check_permission_authorization" (func (;1;) (type 5)))
  (import "env" "action_data_size" (func (;2;) (type 6)))
  (import "env" "read_action_data" (func (;3;) (type 7)))
  (import "env" "current_time" (func (;4;) (type 8)))
  (import "env" "sysio_assert" (func (;5;) (type 9)))
  (import "env" "memcpy" (func (;6;) (type 10)))
  (import "env" "require_auth" (func (;7;) (type 11)))
  (import "env" "db_find_i64" (func (;8;) (type 12)))
  (import "env" "current_receiver" (func (;9;) (type 8)))
  (import "env" "require_auth2" (func (;10;) (type 13)))
  (import "env" "memmove" (func (;11;) (type 10)))
  (import "env" "db_update_i64" (func (;12;) (type 14)))
  (import "env" "db_remove_i64" (func (;13;) (type 2)))
  (import "env" "send_deferred" (func (;14;) (type 15)))
  (import "env" "abort" (func (;15;) (type 3)))
  (import "env" "db_get_i64" (func (;16;) (type 10)))
  (import "env" "db_store_i64" (func (;17;) (type 16)))
  (import "env" "set_blockchain_parameters_packed" (func (;18;) (type 9)))
  (import "env" "get_blockchain_parameters_packed" (func (;19;) (type 7)))
  (import "env" "memset" (func (;20;) (type 10)))
  (func (;21;) (type 3))
  (func (;22;) (type 9) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load offset=8
              local.tee 2
              local.get 0
              i32.load offset=4
              local.tee 3
              i32.sub
              local.get 1
              i32.ge_u
              br_if 0 (;@5;)
              local.get 3
              local.get 0
              i32.load
              local.tee 4
              i32.sub
              local.tee 5
              local.get 1
              i32.add
              local.tee 6
              i32.const -1
              i32.le_s
              br_if 2 (;@3;)
              i32.const 2147483647
              local.set 7
              block  ;; label = @6
                local.get 2
                local.get 4
                i32.sub
                local.tee 2
                i32.const 1073741822
                i32.gt_u
                br_if 0 (;@6;)
                local.get 6
                local.get 2
                i32.const 1
                i32.shl
                local.tee 2
                local.get 2
                local.get 6
                i32.lt_u
                select
                local.tee 7
                i32.eqz
                br_if 2 (;@4;)
              end
              local.get 7
              call 55
              local.set 2
              br 3 (;@2;)
            end
            local.get 0
            i32.const 4
            i32.add
            local.set 0
            loop  ;; label = @5
              local.get 3
              i32.const 0
              i32.store8
              local.get 0
              local.get 0
              i32.load
              i32.const 1
              i32.add
              local.tee 3
              i32.store
              local.get 1
              i32.const -1
              i32.add
              local.tee 1
              br_if 0 (;@5;)
              br 4 (;@1;)
            end
          end
          i32.const 0
          local.set 7
          i32.const 0
          local.set 2
          br 1 (;@2;)
        end
        local.get 0
        call 59
        unreachable
      end
      local.get 2
      local.get 7
      i32.add
      local.set 7
      local.get 3
      local.get 1
      i32.add
      local.get 4
      i32.sub
      local.set 4
      local.get 2
      local.get 5
      i32.add
      local.tee 5
      local.set 3
      loop  ;; label = @2
        local.get 3
        i32.const 0
        i32.store8
        local.get 3
        i32.const 1
        i32.add
        local.set 3
        local.get 1
        i32.const -1
        i32.add
        local.tee 1
        br_if 0 (;@2;)
      end
      local.get 2
      local.get 4
      i32.add
      local.set 4
      local.get 5
      local.get 0
      i32.const 4
      i32.add
      local.tee 6
      i32.load
      local.get 0
      i32.load
      local.tee 1
      i32.sub
      local.tee 3
      i32.sub
      local.set 2
      block  ;; label = @2
        local.get 3
        i32.const 1
        i32.lt_s
        br_if 0 (;@2;)
        local.get 2
        local.get 1
        local.get 3
        call 6
        drop
        local.get 0
        i32.load
        local.set 1
      end
      local.get 0
      local.get 2
      i32.store
      local.get 6
      local.get 4
      i32.store
      local.get 0
      i32.const 8
      i32.add
      local.get 7
      i32.store
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      call 57
      return
    end)
  (func (;23;) (type 2) (param i32)
    (local i32 i32 i32 i64 i32 i64 i32)
    global.get 0
    i32.const 240
    i32.sub
    local.tee 1
    global.set 0
    local.get 1
    local.tee 2
    call 2
    local.tee 3
    i32.store offset=200
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        i32.const 513
        i32.lt_u
        br_if 0 (;@2;)
        local.get 3
        call 51
        local.set 1
        br 1 (;@1;)
      end
      local.get 1
      local.get 3
      i32.const 15
      i32.add
      i32.const -16
      i32.and
      i32.sub
      local.tee 1
      global.set 0
    end
    local.get 2
    local.get 1
    i32.store offset=196
    local.get 1
    local.get 3
    call 3
    drop
    local.get 2
    i64.const 0
    i64.store offset=176
    i32.const 0
    local.set 3
    local.get 2
    i32.const 0
    i32.store offset=168
    local.get 2
    i64.const 0
    i64.store offset=160
    call 4
    local.set 4
    local.get 2
    i32.const 0
    i32.store offset=148
    local.get 2
    i32.const 0
    i32.store8 offset=152
    local.get 2
    i32.const 0
    i32.store offset=156
    local.get 2
    local.get 4
    i64.const 1000000
    i64.div_u
    i32.wrap_i64
    i32.const 60
    i32.add
    i32.store offset=136
    local.get 2
    local.get 2
    i32.load offset=196
    local.tee 1
    i32.store offset=120
    local.get 2
    local.get 1
    i32.store offset=124
    local.get 2
    local.get 1
    local.get 2
    i32.load offset=200
    local.tee 5
    i32.add
    i32.store offset=128
    local.get 5
    i32.const 7
    i32.gt_u
    i32.const 8568
    call 5
    local.get 2
    i32.const 184
    i32.add
    local.get 2
    i32.load offset=124
    i32.const 8
    call 6
    drop
    local.get 2
    local.get 2
    i32.load offset=124
    i32.const 8
    i32.add
    local.tee 1
    i32.store offset=124
    local.get 2
    i32.load offset=128
    local.get 1
    i32.sub
    i32.const 7
    i32.gt_u
    i32.const 8568
    call 5
    local.get 2
    i32.const 176
    i32.add
    local.get 2
    i32.load offset=124
    i32.const 8
    call 6
    drop
    local.get 2
    local.get 2
    i32.load offset=124
    i32.const 8
    i32.add
    i32.store offset=124
    local.get 2
    i32.const 120
    i32.add
    local.get 2
    i32.const 160
    i32.add
    call 24
    drop
    local.get 2
    local.get 2
    i32.load offset=124
    local.get 2
    i32.load offset=120
    i32.sub
    i32.store offset=116
    local.get 2
    i32.const 120
    i32.add
    local.get 2
    i32.const 136
    i32.add
    call 25
    drop
    local.get 2
    i64.load offset=184
    call 7
    call 4
    local.set 4
    local.get 2
    i32.load offset=136
    local.get 4
    i64.const 1000000
    i64.div_u
    i32.wrap_i64
    i32.ge_u
    i32.const 8192
    call 5
    local.get 2
    i32.const 104
    i32.add
    i32.const 0
    i32.store
    local.get 2
    i64.const -1
    i64.store offset=88
    local.get 2
    i64.const 0
    i64.store offset=96
    local.get 2
    local.get 0
    i64.load
    local.tee 4
    i64.store offset=72
    local.get 2
    local.get 2
    i64.load offset=184
    local.tee 6
    i64.store offset=80
    i32.const 0
    local.set 1
    block  ;; label = @1
      local.get 4
      local.get 6
      i64.const -5915097263704637440
      local.get 2
      i64.load offset=176
      call 8
      local.tee 5
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      local.get 2
      i32.const 72
      i32.add
      local.get 5
      call 26
      local.tee 1
      i32.load offset=20
      local.get 2
      i32.const 72
      i32.add
      i32.eq
      i32.const 8577
      call 5
    end
    local.get 1
    i32.eqz
    i32.const 8212
    call 5
    local.get 2
    i32.const 0
    i32.store offset=64
    local.get 2
    i64.const 0
    i64.store offset=56
    local.get 2
    i32.load offset=164
    local.tee 1
    local.get 2
    i32.load offset=160
    local.tee 5
    i32.sub
    local.tee 7
    i32.const 4
    i32.shr_s
    i64.extend_i32_u
    local.set 4
    loop  ;; label = @1
      local.get 3
      i32.const -1
      i32.add
      local.set 3
      local.get 4
      i64.const 7
      i64.shr_u
      local.tee 4
      i64.const 0
      i64.ne
      br_if 0 (;@1;)
    end
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 5
            local.get 1
            i32.eq
            br_if 0 (;@4;)
            local.get 7
            i32.const -16
            i32.and
            local.tee 1
            local.get 3
            i32.ne
            br_if 1 (;@3;)
            i32.const 0
            local.set 1
            i32.const 0
            local.set 3
            br 3 (;@1;)
          end
          i32.const 0
          local.get 3
          i32.sub
          local.set 3
          br 1 (;@2;)
        end
        local.get 1
        local.get 3
        i32.sub
        local.set 3
      end
      local.get 2
      i32.const 56
      i32.add
      local.get 3
      call 22
      local.get 2
      i32.load offset=60
      local.set 1
      local.get 2
      i32.load offset=56
      local.set 3
    end
    local.get 2
    local.get 3
    i32.store offset=20
    local.get 2
    local.get 3
    i32.store offset=16
    local.get 2
    local.get 1
    i32.store offset=24
    local.get 2
    i32.const 16
    i32.add
    local.get 2
    i32.const 160
    i32.add
    call 27
    drop
    local.get 2
    i32.load offset=196
    local.get 2
    i32.load offset=116
    local.tee 3
    i32.add
    local.get 2
    i32.load offset=200
    local.get 3
    i32.sub
    i32.const 0
    i32.const 0
    local.get 2
    i32.load offset=56
    local.tee 3
    local.get 2
    i32.load offset=60
    local.get 3
    i32.sub
    call 0
    i32.const 0
    i32.gt_s
    i32.const 8333
    call 5
    local.get 2
    i64.load offset=184
    local.set 4
    local.get 2
    local.get 2
    i32.const 196
    i32.add
    i32.store offset=20
    local.get 2
    local.get 2
    i32.const 176
    i32.add
    i32.store offset=16
    local.get 2
    local.get 2
    i32.const 116
    i32.add
    i32.store offset=24
    local.get 2
    local.get 2
    i32.const 200
    i32.add
    i32.store offset=28
    local.get 2
    local.get 4
    i64.store offset=232
    local.get 2
    i64.load offset=72
    call 9
    i64.eq
    i32.const 8651
    call 5
    local.get 2
    local.get 2
    i32.const 16
    i32.add
    i32.store offset=212
    local.get 2
    local.get 2
    i32.const 72
    i32.add
    i32.store offset=208
    local.get 2
    local.get 2
    i32.const 232
    i32.add
    i32.store offset=216
    i32.const 32
    call 55
    local.tee 3
    i64.const 0
    i64.store
    local.get 3
    i64.const 0
    i64.store offset=8 align=4
    local.get 3
    i32.const 0
    i32.store offset=16
    local.get 3
    local.get 2
    i32.const 72
    i32.add
    i32.store offset=20
    local.get 2
    i32.const 208
    i32.add
    local.get 3
    call 28
    local.get 2
    local.get 3
    i32.store offset=8
    local.get 2
    local.get 3
    i64.load
    local.tee 4
    i64.store offset=208
    local.get 2
    local.get 3
    i32.load offset=24
    local.tee 5
    i32.store offset=224
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 100
          i32.add
          local.tee 7
          i32.load
          local.tee 1
          local.get 2
          i32.const 72
          i32.add
          i32.const 32
          i32.add
          i32.load
          i32.ge_u
          br_if 0 (;@3;)
          local.get 1
          local.get 4
          i64.store offset=8
          local.get 1
          local.get 5
          i32.store offset=16
          local.get 2
          i32.const 0
          i32.store offset=8
          local.get 1
          local.get 3
          i32.store
          local.get 7
          local.get 1
          i32.const 24
          i32.add
          i32.store
          local.get 2
          i32.load offset=8
          local.set 3
          i32.const 0
          local.set 1
          local.get 2
          i32.const 0
          i32.store offset=8
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          br 1 (;@2;)
        end
        local.get 2
        i32.const 96
        i32.add
        local.get 2
        i32.const 8
        i32.add
        local.get 2
        i32.const 208
        i32.add
        local.get 2
        i32.const 224
        i32.add
        call 29
        local.get 2
        i32.load offset=8
        local.set 3
        i32.const 0
        local.set 1
        local.get 2
        i32.const 0
        i32.store offset=8
        local.get 3
        i32.eqz
        br_if 1 (;@1;)
      end
      block  ;; label = @2
        local.get 3
        i32.load offset=8
        local.tee 5
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        i32.const 12
        i32.add
        local.get 5
        i32.store
        local.get 5
        call 57
      end
      local.get 3
      call 57
    end
    local.get 2
    i32.const 48
    i32.add
    local.tee 5
    local.get 1
    i32.store
    local.get 2
    i64.const -1
    i64.store offset=32
    local.get 2
    i64.const 0
    i64.store offset=40
    local.get 2
    local.get 0
    i64.load
    local.tee 4
    i64.store offset=16
    local.get 2
    local.get 2
    i64.load offset=184
    local.tee 6
    i64.store offset=24
    local.get 2
    local.get 2
    i32.const 160
    i32.add
    i32.store offset=12
    local.get 2
    local.get 2
    i32.const 176
    i32.add
    i32.store offset=8
    local.get 2
    local.get 6
    i64.store offset=232
    local.get 4
    call 9
    i64.eq
    i32.const 8651
    call 5
    local.get 2
    local.get 2
    i32.const 8
    i32.add
    i32.store offset=212
    local.get 2
    local.get 2
    i32.const 16
    i32.add
    i32.store offset=208
    local.get 2
    local.get 2
    i32.const 232
    i32.add
    i32.store offset=216
    i32.const 48
    call 55
    local.tee 3
    i64.const 0
    i64.store
    local.get 3
    i64.const 0
    i64.store offset=8 align=4
    local.get 3
    i64.const 0
    i64.store offset=16 align=4
    local.get 3
    i64.const 0
    i64.store offset=24 align=4
    local.get 3
    local.get 2
    i32.const 16
    i32.add
    i32.store offset=32
    local.get 2
    i32.const 208
    i32.add
    local.get 3
    call 30
    local.get 2
    local.get 3
    i32.store offset=224
    local.get 2
    local.get 3
    i64.load
    local.tee 4
    i64.store offset=208
    local.get 2
    local.get 3
    i32.load offset=36
    local.tee 1
    i32.store offset=204
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i32.const 44
              i32.add
              local.tee 7
              i32.load
              local.tee 0
              local.get 5
              i32.load
              i32.ge_u
              br_if 0 (;@5;)
              local.get 0
              local.get 4
              i64.store offset=8
              local.get 0
              local.get 1
              i32.store offset=16
              local.get 2
              i32.const 0
              i32.store offset=224
              local.get 0
              local.get 3
              i32.store
              local.get 7
              local.get 0
              i32.const 24
              i32.add
              i32.store
              local.get 2
              i32.load offset=224
              local.set 3
              local.get 2
              i32.const 0
              i32.store offset=224
              local.get 3
              i32.eqz
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
            local.get 2
            i32.const 40
            i32.add
            local.get 2
            i32.const 224
            i32.add
            local.get 2
            i32.const 208
            i32.add
            local.get 2
            i32.const 204
            i32.add
            call 31
            local.get 2
            i32.load offset=224
            local.set 3
            local.get 2
            i32.const 0
            i32.store offset=224
            local.get 3
            br_if 1 (;@3;)
          end
          local.get 2
          i32.load offset=40
          local.tee 5
          i32.eqz
          br_if 2 (;@1;)
          br 1 (;@2;)
        end
        block  ;; label = @3
          local.get 3
          i32.load offset=20
          local.tee 0
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          i32.const 24
          i32.add
          local.get 0
          i32.store
          local.get 0
          call 57
        end
        block  ;; label = @3
          local.get 3
          i32.load offset=8
          local.tee 0
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          i32.const 12
          i32.add
          local.get 0
          i32.store
          local.get 0
          call 57
        end
        local.get 3
        call 57
        local.get 2
        i32.load offset=40
        local.tee 5
        i32.eqz
        br_if 1 (;@1;)
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 44
          i32.add
          local.tee 7
          i32.load
          local.tee 0
          local.get 5
          i32.eq
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 0
            i32.const -24
            i32.add
            local.tee 0
            i32.load
            local.set 3
            local.get 0
            i32.const 0
            i32.store
            block  ;; label = @5
              local.get 3
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 3
                i32.load offset=20
                local.tee 1
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.const 24
                i32.add
                local.get 1
                i32.store
                local.get 1
                call 57
              end
              block  ;; label = @6
                local.get 3
                i32.load offset=8
                local.tee 1
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.const 12
                i32.add
                local.get 1
                i32.store
                local.get 1
                call 57
              end
              local.get 3
              call 57
            end
            local.get 5
            local.get 0
            i32.ne
            br_if 0 (;@4;)
          end
          local.get 2
          i32.const 40
          i32.add
          i32.load
          local.set 3
          br 1 (;@2;)
        end
        local.get 5
        local.set 3
      end
      local.get 7
      local.get 5
      i32.store
      local.get 3
      call 57
    end
    block  ;; label = @1
      local.get 2
      i32.load offset=56
      local.tee 3
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      local.get 3
      i32.store offset=60
      local.get 3
      call 57
    end
    block  ;; label = @1
      local.get 2
      i32.load offset=96
      local.tee 5
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 100
          i32.add
          local.tee 7
          i32.load
          local.tee 3
          local.get 5
          i32.eq
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 3
            i32.const -24
            i32.add
            local.tee 3
            i32.load
            local.set 0
            local.get 3
            i32.const 0
            i32.store
            block  ;; label = @5
              local.get 0
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 0
                i32.load offset=8
                local.tee 1
                i32.eqz
                br_if 0 (;@6;)
                local.get 0
                i32.const 12
                i32.add
                local.get 1
                i32.store
                local.get 1
                call 57
              end
              local.get 0
              call 57
            end
            local.get 5
            local.get 3
            i32.ne
            br_if 0 (;@4;)
          end
          local.get 2
          i32.const 96
          i32.add
          i32.load
          local.set 3
          br 1 (;@2;)
        end
        local.get 5
        local.set 3
      end
      local.get 7
      local.get 5
      i32.store
      local.get 3
      call 57
    end
    block  ;; label = @1
      local.get 2
      i32.load offset=160
      local.tee 3
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      local.get 3
      i32.store offset=164
      local.get 3
      call 57
    end
    local.get 2
    i32.const 240
    i32.add
    global.set 0)
  (func (;24;) (type 7) (param i32 i32) (result i32)
    (local i32 i32 i64 i32 i32 i32)
    local.get 0
    i32.load offset=4
    local.set 2
    i32.const 0
    local.set 3
    i64.const 0
    local.set 4
    local.get 0
    i32.const 8
    i32.add
    local.set 5
    local.get 0
    i32.const 4
    i32.add
    local.set 6
    loop  ;; label = @1
      local.get 2
      local.get 5
      i32.load
      i32.lt_u
      i32.const 8573
      call 5
      local.get 6
      i32.load
      local.tee 2
      i32.load8_u
      local.set 7
      local.get 6
      local.get 2
      i32.const 1
      i32.add
      local.tee 2
      i32.store
      local.get 4
      local.get 7
      i32.const 127
      i32.and
      local.get 3
      i32.const 255
      i32.and
      local.tee 3
      i32.shl
      i64.extend_i32_u
      i64.or
      local.set 4
      local.get 3
      i32.const 7
      i32.add
      local.set 3
      local.get 7
      i32.const 128
      i32.and
      br_if 0 (;@1;)
    end
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.load offset=4
          local.tee 5
          local.get 1
          i32.load
          local.tee 2
          i32.sub
          i32.const 4
          i32.shr_s
          local.tee 3
          local.get 4
          i32.wrap_i64
          local.tee 7
          i32.ge_u
          br_if 0 (;@3;)
          local.get 1
          local.get 7
          local.get 3
          i32.sub
          call 32
          local.get 1
          i32.load
          local.tee 2
          local.get 1
          i32.const 4
          i32.add
          i32.load
          local.tee 5
          i32.ne
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        block  ;; label = @3
          local.get 3
          local.get 7
          i32.le_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 4
          i32.add
          local.get 2
          local.get 7
          i32.const 4
          i32.shl
          i32.add
          local.tee 5
          i32.store
        end
        local.get 2
        local.get 5
        i32.eq
        br_if 1 (;@1;)
      end
      local.get 0
      i32.const 4
      i32.add
      local.tee 7
      i32.load
      local.set 3
      loop  ;; label = @2
        local.get 0
        i32.const 8
        i32.add
        local.tee 6
        i32.load
        local.get 3
        i32.sub
        i32.const 7
        i32.gt_u
        i32.const 8568
        call 5
        local.get 2
        local.get 7
        i32.load
        i32.const 8
        call 6
        drop
        local.get 7
        local.get 7
        i32.load
        i32.const 8
        i32.add
        local.tee 3
        i32.store
        local.get 6
        i32.load
        local.get 3
        i32.sub
        i32.const 7
        i32.gt_u
        i32.const 8568
        call 5
        local.get 2
        i32.const 8
        i32.add
        local.get 7
        i32.load
        i32.const 8
        call 6
        drop
        local.get 7
        local.get 7
        i32.load
        i32.const 8
        i32.add
        local.tee 3
        i32.store
        local.get 2
        i32.const 16
        i32.add
        local.tee 2
        local.get 5
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (func (;25;) (type 7) (param i32 i32) (result i32)
    (local i32 i32 i32 i64 i32 i32)
    local.get 0
    i32.load offset=8
    local.get 0
    i32.load offset=4
    i32.sub
    i32.const 3
    i32.gt_u
    i32.const 8568
    call 5
    local.get 1
    local.get 0
    i32.load offset=4
    i32.const 4
    call 6
    drop
    local.get 0
    local.get 0
    i32.load offset=4
    i32.const 4
    i32.add
    local.tee 2
    i32.store offset=4
    local.get 0
    i32.load offset=8
    local.get 2
    i32.sub
    i32.const 1
    i32.gt_u
    i32.const 8568
    call 5
    local.get 1
    i32.const 4
    i32.add
    local.get 0
    i32.load offset=4
    i32.const 2
    call 6
    drop
    local.get 0
    local.get 0
    i32.load offset=4
    i32.const 2
    i32.add
    local.tee 2
    i32.store offset=4
    local.get 0
    i32.load offset=8
    local.get 2
    i32.sub
    i32.const 3
    i32.gt_u
    i32.const 8568
    call 5
    local.get 1
    i32.const 8
    i32.add
    local.get 0
    i32.load offset=4
    i32.const 4
    call 6
    drop
    local.get 0
    local.get 0
    i32.load offset=4
    i32.const 4
    i32.add
    local.tee 3
    i32.store offset=4
    i32.const 0
    local.set 4
    i64.const 0
    local.set 5
    loop  ;; label = @1
      local.get 3
      local.get 0
      i32.const 8
      i32.add
      i32.load
      i32.lt_u
      i32.const 8573
      call 5
      local.get 0
      i32.const 4
      i32.add
      local.tee 6
      i32.load
      local.tee 3
      i32.load8_u
      local.set 2
      local.get 6
      local.get 3
      i32.const 1
      i32.add
      local.tee 3
      i32.store
      local.get 5
      local.get 2
      i32.const 127
      i32.and
      local.get 4
      i32.const 255
      i32.and
      local.tee 4
      i32.shl
      i64.extend_i32_u
      i64.or
      local.set 5
      local.get 4
      i32.const 7
      i32.add
      local.set 4
      local.get 2
      i32.const 128
      i32.and
      br_if 0 (;@1;)
    end
    local.get 1
    local.get 5
    i64.store32 offset=12
    local.get 0
    i32.const 8
    i32.add
    local.tee 7
    i32.load
    local.get 3
    i32.ne
    i32.const 8568
    call 5
    local.get 1
    i32.const 16
    i32.add
    local.get 0
    i32.const 4
    i32.add
    local.tee 3
    i32.load
    i32.const 1
    call 6
    drop
    local.get 3
    local.get 3
    i32.load
    i32.const 1
    i32.add
    local.tee 4
    i32.store
    i32.const 0
    local.set 6
    i64.const 0
    local.set 5
    loop  ;; label = @1
      local.get 4
      local.get 7
      i32.load
      i32.lt_u
      i32.const 8573
      call 5
      local.get 3
      i32.load
      local.tee 4
      i32.load8_u
      local.set 2
      local.get 3
      local.get 4
      i32.const 1
      i32.add
      local.tee 4
      i32.store
      local.get 5
      local.get 2
      i32.const 127
      i32.and
      local.get 6
      i32.const 255
      i32.and
      local.tee 6
      i32.shl
      i64.extend_i32_u
      i64.or
      local.set 5
      local.get 6
      i32.const 7
      i32.add
      local.set 6
      local.get 2
      i32.const 128
      i32.and
      br_if 0 (;@1;)
    end
    local.get 1
    local.get 5
    i64.store32 offset=20
    local.get 0)
  (func (;26;) (type 7) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i64)
    global.get 0
    i32.const 48
    i32.sub
    local.tee 2
    local.set 3
    local.get 2
    global.set 0
    block  ;; label = @1
      local.get 0
      i32.load offset=24
      local.tee 4
      local.get 0
      i32.const 28
      i32.add
      i32.load
      local.tee 5
      i32.eq
      br_if 0 (;@1;)
      block  ;; label = @2
        loop  ;; label = @3
          local.get 5
          i32.const -8
          i32.add
          i32.load
          local.get 1
          i32.eq
          br_if 1 (;@2;)
          local.get 4
          local.get 5
          i32.const -24
          i32.add
          local.tee 5
          i32.ne
          br_if 0 (;@3;)
          br 2 (;@1;)
        end
      end
      local.get 4
      local.get 5
      i32.eq
      br_if 0 (;@1;)
      local.get 5
      i32.const -24
      i32.add
      i32.load
      local.set 5
      local.get 3
      i32.const 48
      i32.add
      global.set 0
      local.get 5
      return
    end
    local.get 1
    i32.const 0
    i32.const 0
    call 16
    local.tee 5
    i32.const 31
    i32.shr_u
    i32.const 1
    i32.xor
    i32.const 8628
    call 5
    block  ;; label = @1
      block  ;; label = @2
        local.get 5
        i32.const 513
        i32.lt_u
        br_if 0 (;@2;)
        local.get 5
        call 51
        local.set 4
        br 1 (;@1;)
      end
      local.get 2
      local.get 5
      i32.const 15
      i32.add
      i32.const -16
      i32.and
      i32.sub
      local.tee 4
      global.set 0
    end
    local.get 1
    local.get 4
    local.get 5
    call 16
    drop
    local.get 3
    local.get 4
    i32.store offset=36
    local.get 3
    local.get 4
    i32.store offset=32
    local.get 3
    local.get 4
    local.get 5
    i32.add
    local.tee 2
    i32.store offset=40
    block  ;; label = @1
      local.get 5
      i32.const 512
      i32.le_u
      br_if 0 (;@1;)
      local.get 4
      call 54
      local.get 3
      i32.const 40
      i32.add
      i32.load
      local.set 2
      local.get 3
      i32.load offset=36
      local.set 4
    end
    i32.const 32
    call 55
    local.tee 5
    i64.const 0
    i64.store
    local.get 5
    i64.const 0
    i64.store offset=8 align=4
    local.get 5
    i32.const 0
    i32.store offset=16
    local.get 5
    local.get 0
    i32.store offset=20
    local.get 2
    local.get 4
    i32.sub
    i32.const 7
    i32.gt_u
    i32.const 8568
    call 5
    local.get 5
    local.get 4
    i32.const 8
    call 6
    drop
    local.get 3
    local.get 4
    i32.const 8
    i32.add
    i32.store offset=36
    local.get 3
    i32.const 32
    i32.add
    local.get 5
    i32.const 8
    i32.add
    call 50
    drop
    local.get 5
    local.get 1
    i32.store offset=24
    local.get 3
    local.get 5
    i32.store offset=24
    local.get 3
    local.get 5
    i64.load
    local.tee 6
    i64.store offset=16
    local.get 3
    local.get 1
    i32.store offset=12
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.const 28
          i32.add
          local.tee 2
          i32.load
          local.tee 4
          local.get 0
          i32.const 32
          i32.add
          i32.load
          i32.ge_u
          br_if 0 (;@3;)
          local.get 4
          local.get 6
          i64.store offset=8
          local.get 4
          local.get 1
          i32.store offset=16
          local.get 3
          i32.const 0
          i32.store offset=24
          local.get 4
          local.get 5
          i32.store
          local.get 2
          local.get 4
          i32.const 24
          i32.add
          i32.store
          local.get 3
          i32.load offset=24
          local.set 1
          local.get 3
          i32.const 0
          i32.store offset=24
          local.get 1
          i32.eqz
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 0
        i32.const 24
        i32.add
        local.get 3
        i32.const 24
        i32.add
        local.get 3
        i32.const 16
        i32.add
        local.get 3
        i32.const 12
        i32.add
        call 29
        local.get 3
        i32.load offset=24
        local.set 1
        local.get 3
        i32.const 0
        i32.store offset=24
        local.get 1
        br_if 1 (;@1;)
      end
      local.get 3
      i32.const 48
      i32.add
      global.set 0
      local.get 5
      return
    end
    block  ;; label = @1
      local.get 1
      i32.load offset=8
      local.tee 4
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.const 12
      i32.add
      local.get 4
      i32.store
      local.get 4
      call 57
    end
    local.get 1
    call 57
    local.get 3
    i32.const 48
    i32.add
    global.set 0
    local.get 5)
  (func (;27;) (type 7) (param i32 i32) (result i32)
    (local i32 i64 i32 i32 i32 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 2
    global.set 0
    local.get 1
    i32.load offset=4
    local.get 1
    i32.load
    i32.sub
    i32.const 4
    i32.shr_s
    i64.extend_i32_u
    local.set 3
    local.get 0
    i32.load offset=4
    local.set 4
    local.get 0
    i32.const 8
    i32.add
    local.set 5
    loop  ;; label = @1
      local.get 3
      i32.wrap_i64
      local.set 6
      local.get 2
      local.get 3
      i64.const 7
      i64.shr_u
      local.tee 3
      i64.const 0
      i64.ne
      local.tee 7
      i32.const 7
      i32.shl
      local.get 6
      i32.const 127
      i32.and
      i32.or
      i32.store8 offset=15
      local.get 5
      i32.load
      local.get 4
      i32.sub
      i32.const 0
      i32.gt_s
      i32.const 8562
      call 5
      local.get 0
      i32.const 4
      i32.add
      local.tee 6
      i32.load
      local.get 2
      i32.const 15
      i32.add
      i32.const 1
      call 6
      drop
      local.get 6
      local.get 6
      i32.load
      i32.const 1
      i32.add
      local.tee 4
      i32.store
      local.get 7
      br_if 0 (;@1;)
    end
    block  ;; label = @1
      local.get 1
      i32.load
      local.tee 7
      local.get 1
      i32.const 4
      i32.add
      i32.load
      local.tee 1
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      i32.const 4
      i32.add
      local.set 6
      loop  ;; label = @2
        local.get 0
        i32.const 8
        i32.add
        local.tee 5
        i32.load
        local.get 4
        i32.sub
        i32.const 7
        i32.gt_s
        i32.const 8562
        call 5
        local.get 6
        i32.load
        local.get 7
        i32.const 8
        call 6
        drop
        local.get 6
        local.get 6
        i32.load
        i32.const 8
        i32.add
        local.tee 4
        i32.store
        local.get 5
        i32.load
        local.get 4
        i32.sub
        i32.const 7
        i32.gt_s
        i32.const 8562
        call 5
        local.get 6
        i32.load
        local.get 7
        i32.const 8
        i32.add
        i32.const 8
        call 6
        drop
        local.get 6
        local.get 6
        i32.load
        i32.const 8
        i32.add
        local.tee 4
        i32.store
        local.get 7
        i32.const 16
        i32.add
        local.tee 7
        local.get 1
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 2
    i32.const 16
    i32.add
    global.set 0
    local.get 0)
  (func (;28;) (type 9) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i64 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 2
    global.set 0
    local.get 1
    local.get 0
    i32.load offset=4
    local.tee 3
    i32.load
    i64.load
    i64.store
    local.get 0
    i32.load
    local.set 4
    local.get 3
    i32.load offset=4
    i32.load
    local.set 5
    local.get 2
    local.tee 6
    i64.const 0
    i64.store
    i32.const 0
    local.set 7
    local.get 6
    i32.const 0
    i32.store offset=8
    i32.const 0
    local.set 8
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 5
          local.get 3
          i32.load offset=12
          i32.load
          i32.add
          local.get 5
          local.get 3
          i32.load offset=8
          i32.load
          i32.add
          local.tee 5
          i32.sub
          local.tee 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          i32.const -1
          i32.le_s
          br_if 1 (;@2;)
          local.get 6
          i32.const 8
          i32.add
          local.get 3
          call 55
          local.tee 8
          local.get 3
          i32.add
          local.tee 7
          i32.store
          local.get 6
          local.get 8
          i32.store
          local.get 8
          local.get 5
          local.get 3
          call 6
          drop
          local.get 6
          local.get 7
          i32.store offset=4
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.load offset=8
            local.tee 3
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            i32.const 12
            i32.add
            local.get 3
            i32.store
            local.get 3
            call 57
            local.get 1
            i32.const 16
            i32.add
            local.tee 3
            i32.const 0
            i32.store
            local.get 1
            i64.const 0
            i64.store offset=8 align=4
            br 1 (;@3;)
          end
          local.get 1
          i32.const 16
          i32.add
          local.set 3
        end
        local.get 3
        local.get 7
        i32.store
        local.get 1
        i32.const 12
        i32.add
        local.get 7
        i32.store
        local.get 1
        i32.const 8
        i32.add
        local.get 8
        i32.store
        local.get 7
        i32.const 8
        i32.add
        local.get 8
        i32.sub
        local.set 3
        local.get 7
        local.get 8
        i32.sub
        i64.extend_i32_u
        local.set 9
        loop  ;; label = @3
          local.get 3
          i32.const 1
          i32.add
          local.set 3
          local.get 9
          i64.const 7
          i64.shr_u
          local.tee 9
          i64.const 0
          i64.ne
          br_if 0 (;@3;)
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const 513
            i32.lt_u
            br_if 0 (;@4;)
            local.get 3
            call 51
            local.set 10
            br 1 (;@3;)
          end
          local.get 2
          local.get 3
          i32.const 15
          i32.add
          i32.const -16
          i32.and
          i32.sub
          local.tee 10
          global.set 0
        end
        local.get 3
        i32.const 7
        i32.gt_s
        i32.const 8562
        call 5
        local.get 10
        local.get 1
        i32.const 8
        call 6
        drop
        local.get 1
        i32.const 12
        i32.add
        i32.load
        local.get 1
        i32.const 8
        i32.add
        i32.load
        i32.sub
        i64.extend_i32_u
        local.set 9
        local.get 10
        i32.const 8
        i32.add
        local.set 7
        local.get 10
        local.get 3
        i32.add
        local.set 2
        loop  ;; label = @3
          local.get 9
          i32.wrap_i64
          local.set 8
          local.get 6
          local.get 9
          i64.const 7
          i64.shr_u
          local.tee 9
          i64.const 0
          i64.ne
          local.tee 5
          i32.const 7
          i32.shl
          local.get 8
          i32.const 127
          i32.and
          i32.or
          i32.store8 offset=15
          local.get 2
          local.get 7
          i32.sub
          i32.const 0
          i32.gt_s
          i32.const 8562
          call 5
          local.get 7
          local.get 6
          i32.const 15
          i32.add
          i32.const 1
          call 6
          drop
          local.get 7
          i32.const 1
          i32.add
          local.set 7
          local.get 5
          br_if 0 (;@3;)
        end
        local.get 2
        local.get 7
        i32.sub
        local.get 1
        i32.const 12
        i32.add
        i32.load
        local.get 1
        i32.const 8
        i32.add
        i32.load
        local.tee 8
        i32.sub
        local.tee 5
        i32.ge_s
        i32.const 8562
        call 5
        local.get 7
        local.get 8
        local.get 5
        call 6
        drop
        local.get 1
        local.get 4
        i64.load offset=8
        i64.const -5915097263704637440
        local.get 0
        i32.load offset=8
        i64.load
        local.get 1
        i64.load
        local.tee 9
        local.get 10
        local.get 3
        call 17
        i32.store offset=24
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const 513
            i32.ge_u
            br_if 0 (;@4;)
            local.get 9
            local.get 4
            i64.load offset=16
            i64.ge_u
            br_if 1 (;@3;)
            br 3 (;@1;)
          end
          local.get 10
          call 54
          local.get 9
          local.get 4
          i64.load offset=16
          i64.lt_u
          br_if 2 (;@1;)
        end
        local.get 4
        i32.const 16
        i32.add
        i64.const -2
        local.get 9
        i64.const 1
        i64.add
        local.get 9
        i64.const -3
        i64.gt_u
        select
        i64.store
        local.get 6
        i32.const 16
        i32.add
        global.set 0
        return
      end
      local.get 6
      call 59
      unreachable
    end
    local.get 6
    i32.const 16
    i32.add
    global.set 0)
  (func (;29;) (type 17) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.get 0
        i32.load
        local.tee 4
        i32.sub
        i32.const 24
        i32.div_s
        local.tee 5
        i32.const 1
        i32.add
        local.tee 6
        i32.const 178956971
        i32.ge_u
        br_if 0 (;@2;)
        i32.const 178956970
        local.set 7
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load offset=8
            local.get 4
            i32.sub
            i32.const 24
            i32.div_s
            local.tee 4
            i32.const 89478484
            i32.gt_u
            br_if 0 (;@4;)
            local.get 6
            local.get 4
            i32.const 1
            i32.shl
            local.tee 7
            local.get 7
            local.get 6
            i32.lt_u
            select
            local.tee 7
            i32.eqz
            br_if 1 (;@3;)
          end
          local.get 7
          i32.const 24
          i32.mul
          call 55
          local.set 4
          br 2 (;@1;)
        end
        i32.const 0
        local.set 7
        i32.const 0
        local.set 4
        br 1 (;@1;)
      end
      local.get 0
      call 59
      unreachable
    end
    local.get 1
    i32.load
    local.set 6
    local.get 1
    i32.const 0
    i32.store
    local.get 4
    local.get 5
    i32.const 24
    i32.mul
    local.tee 8
    i32.add
    local.tee 1
    local.get 6
    i32.store
    local.get 1
    local.get 2
    i64.load
    i64.store offset=8
    local.get 1
    local.get 3
    i32.load
    i32.store offset=16
    local.get 4
    local.get 7
    i32.const 24
    i32.mul
    i32.add
    local.set 5
    local.get 1
    i32.const 24
    i32.add
    local.set 6
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.tee 2
        local.get 0
        i32.load
        local.tee 7
        i32.eq
        br_if 0 (;@2;)
        local.get 4
        local.get 8
        i32.add
        i32.const -24
        i32.add
        local.set 1
        loop  ;; label = @3
          local.get 2
          i32.const -24
          i32.add
          local.tee 4
          i32.load
          local.set 3
          local.get 4
          i32.const 0
          i32.store
          local.get 1
          local.get 3
          i32.store
          local.get 1
          i32.const 16
          i32.add
          local.get 2
          i32.const -8
          i32.add
          i32.load
          i32.store
          local.get 1
          i32.const 8
          i32.add
          local.get 2
          i32.const -16
          i32.add
          i64.load
          i64.store
          local.get 1
          i32.const -24
          i32.add
          local.set 1
          local.get 4
          local.set 2
          local.get 7
          local.get 4
          i32.ne
          br_if 0 (;@3;)
        end
        local.get 1
        i32.const 24
        i32.add
        local.set 1
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.set 7
        local.get 0
        i32.load
        local.set 4
        br 1 (;@1;)
      end
      local.get 7
      local.set 4
    end
    local.get 0
    local.get 1
    i32.store
    local.get 0
    i32.const 4
    i32.add
    local.get 6
    i32.store
    local.get 0
    i32.const 8
    i32.add
    local.get 5
    i32.store
    block  ;; label = @1
      local.get 7
      local.get 4
      i32.eq
      br_if 0 (;@1;)
      loop  ;; label = @2
        local.get 7
        i32.const -24
        i32.add
        local.tee 7
        i32.load
        local.set 1
        local.get 7
        i32.const 0
        i32.store
        block  ;; label = @3
          local.get 1
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 1
            i32.load offset=8
            local.tee 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            i32.const 12
            i32.add
            local.get 2
            i32.store
            local.get 2
            call 57
          end
          local.get 1
          call 57
        end
        local.get 4
        local.get 7
        i32.ne
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      local.get 4
      i32.eqz
      br_if 0 (;@1;)
      local.get 4
      call 57
    end)
  (func (;30;) (type 9) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i64 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 2
    local.set 3
    local.get 2
    global.set 0
    local.get 1
    local.get 0
    i32.load offset=4
    local.tee 4
    i32.load
    i64.load
    i64.store
    local.get 1
    i32.const 8
    i32.add
    local.set 5
    local.get 0
    i32.load
    local.set 6
    local.get 4
    i32.load offset=4
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.load offset=8
        local.tee 7
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        i32.const 12
        i32.add
        local.tee 8
        local.get 7
        i32.store
        local.get 7
        call 57
        local.get 1
        i32.const 16
        i32.add
        local.tee 7
        i32.const 0
        i32.store
        local.get 1
        i64.const 0
        i64.store offset=8 align=4
        br 1 (;@1;)
      end
      local.get 1
      i32.const 16
      i32.add
      local.set 7
      local.get 1
      i32.const 12
      i32.add
      local.set 8
    end
    local.get 5
    local.get 4
    i32.load
    i32.store
    local.get 8
    local.get 4
    i32.load offset=4
    i32.store
    local.get 7
    local.get 4
    i32.load offset=8
    i32.store
    local.get 4
    i64.const 0
    i64.store align=4
    local.get 4
    i32.const 0
    i32.store offset=8
    local.get 8
    i32.load
    local.tee 8
    local.get 5
    i32.load
    local.tee 7
    i32.sub
    local.tee 9
    i32.const 4
    i32.shr_s
    i64.extend_i32_u
    local.set 10
    i32.const 8
    local.set 4
    loop  ;; label = @1
      local.get 4
      i32.const 1
      i32.add
      local.set 4
      local.get 10
      i64.const 7
      i64.shr_u
      local.tee 10
      i64.const 0
      i64.ne
      br_if 0 (;@1;)
    end
    block  ;; label = @1
      local.get 7
      local.get 8
      i32.eq
      br_if 0 (;@1;)
      local.get 9
      i32.const -16
      i32.and
      local.get 4
      i32.add
      local.set 4
    end
    local.get 1
    i32.const 20
    i32.add
    local.set 7
    local.get 1
    i32.const 24
    i32.add
    i32.load
    local.tee 8
    local.get 1
    i32.load offset=20
    local.tee 9
    i32.sub
    local.tee 11
    i32.const 4
    i32.shr_s
    i64.extend_i32_u
    local.set 10
    loop  ;; label = @1
      local.get 4
      i32.const 1
      i32.add
      local.set 4
      local.get 10
      i64.const 7
      i64.shr_u
      local.tee 10
      i64.const 0
      i64.ne
      br_if 0 (;@1;)
    end
    block  ;; label = @1
      local.get 9
      local.get 8
      i32.eq
      br_if 0 (;@1;)
      local.get 11
      i32.const -16
      i32.and
      local.get 4
      i32.add
      local.set 4
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 4
        i32.const 513
        i32.lt_u
        br_if 0 (;@2;)
        local.get 4
        call 51
        local.set 8
        br 1 (;@1;)
      end
      local.get 2
      local.get 4
      i32.const 15
      i32.add
      i32.const -16
      i32.and
      i32.sub
      local.tee 8
      global.set 0
    end
    local.get 3
    local.get 8
    i32.store
    local.get 3
    local.get 8
    local.get 4
    i32.add
    i32.store offset=8
    local.get 4
    i32.const 7
    i32.gt_s
    i32.const 8562
    call 5
    local.get 8
    local.get 1
    i32.const 8
    call 6
    drop
    local.get 3
    local.get 8
    i32.const 8
    i32.add
    i32.store offset=4
    local.get 3
    local.get 5
    call 27
    drop
    local.get 3
    local.get 7
    call 27
    drop
    local.get 1
    local.get 6
    i64.load offset=8
    i64.const 3849304914312298496
    local.get 0
    i32.load offset=8
    i64.load
    local.get 1
    i64.load
    local.tee 10
    local.get 8
    local.get 4
    call 17
    i32.store offset=36
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          i32.const 513
          i32.ge_u
          br_if 0 (;@3;)
          local.get 10
          local.get 6
          i64.load offset=16
          i64.ge_u
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 8
        call 54
        local.get 10
        local.get 6
        i64.load offset=16
        i64.lt_u
        br_if 1 (;@1;)
      end
      local.get 6
      i32.const 16
      i32.add
      i64.const -2
      local.get 10
      i64.const 1
      i64.add
      local.get 10
      i64.const -3
      i64.gt_u
      select
      i64.store
      local.get 3
      i32.const 16
      i32.add
      global.set 0
      return
    end
    local.get 3
    i32.const 16
    i32.add
    global.set 0)
  (func (;31;) (type 17) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.get 0
        i32.load
        local.tee 4
        i32.sub
        i32.const 24
        i32.div_s
        local.tee 5
        i32.const 1
        i32.add
        local.tee 6
        i32.const 178956971
        i32.ge_u
        br_if 0 (;@2;)
        i32.const 178956970
        local.set 7
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load offset=8
            local.get 4
            i32.sub
            i32.const 24
            i32.div_s
            local.tee 4
            i32.const 89478484
            i32.gt_u
            br_if 0 (;@4;)
            local.get 6
            local.get 4
            i32.const 1
            i32.shl
            local.tee 7
            local.get 7
            local.get 6
            i32.lt_u
            select
            local.tee 7
            i32.eqz
            br_if 1 (;@3;)
          end
          local.get 7
          i32.const 24
          i32.mul
          call 55
          local.set 4
          br 2 (;@1;)
        end
        i32.const 0
        local.set 7
        i32.const 0
        local.set 4
        br 1 (;@1;)
      end
      local.get 0
      call 59
      unreachable
    end
    local.get 1
    i32.load
    local.set 6
    local.get 1
    i32.const 0
    i32.store
    local.get 4
    local.get 5
    i32.const 24
    i32.mul
    local.tee 8
    i32.add
    local.tee 1
    local.get 6
    i32.store
    local.get 1
    local.get 2
    i64.load
    i64.store offset=8
    local.get 1
    local.get 3
    i32.load
    i32.store offset=16
    local.get 4
    local.get 7
    i32.const 24
    i32.mul
    i32.add
    local.set 5
    local.get 1
    i32.const 24
    i32.add
    local.set 6
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.tee 2
        local.get 0
        i32.load
        local.tee 7
        i32.eq
        br_if 0 (;@2;)
        local.get 4
        local.get 8
        i32.add
        i32.const -24
        i32.add
        local.set 1
        loop  ;; label = @3
          local.get 2
          i32.const -24
          i32.add
          local.tee 4
          i32.load
          local.set 3
          local.get 4
          i32.const 0
          i32.store
          local.get 1
          local.get 3
          i32.store
          local.get 1
          i32.const 16
          i32.add
          local.get 2
          i32.const -8
          i32.add
          i32.load
          i32.store
          local.get 1
          i32.const 8
          i32.add
          local.get 2
          i32.const -16
          i32.add
          i64.load
          i64.store
          local.get 1
          i32.const -24
          i32.add
          local.set 1
          local.get 4
          local.set 2
          local.get 7
          local.get 4
          i32.ne
          br_if 0 (;@3;)
        end
        local.get 1
        i32.const 24
        i32.add
        local.set 1
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.set 7
        local.get 0
        i32.load
        local.set 4
        br 1 (;@1;)
      end
      local.get 7
      local.set 4
    end
    local.get 0
    local.get 1
    i32.store
    local.get 0
    i32.const 4
    i32.add
    local.get 6
    i32.store
    local.get 0
    i32.const 8
    i32.add
    local.get 5
    i32.store
    block  ;; label = @1
      local.get 7
      local.get 4
      i32.eq
      br_if 0 (;@1;)
      loop  ;; label = @2
        local.get 7
        i32.const -24
        i32.add
        local.tee 7
        i32.load
        local.set 1
        local.get 7
        i32.const 0
        i32.store
        block  ;; label = @3
          local.get 1
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 1
            i32.load offset=20
            local.tee 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            i32.const 24
            i32.add
            local.get 2
            i32.store
            local.get 2
            call 57
          end
          block  ;; label = @4
            local.get 1
            i32.load offset=8
            local.tee 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            i32.const 12
            i32.add
            local.get 2
            i32.store
            local.get 2
            call 57
          end
          local.get 1
          call 57
        end
        local.get 4
        local.get 7
        i32.ne
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      local.get 4
      i32.eqz
      br_if 0 (;@1;)
      local.get 4
      call 57
    end)
  (func (;32;) (type 9) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load offset=8
              local.tee 2
              local.get 0
              i32.load offset=4
              local.tee 3
              i32.sub
              i32.const 4
              i32.shr_s
              local.get 1
              i32.ge_u
              br_if 0 (;@5;)
              local.get 3
              local.get 0
              i32.load
              local.tee 4
              i32.sub
              i32.const 4
              i32.shr_s
              local.tee 5
              local.get 1
              i32.add
              local.tee 6
              i32.const 268435456
              i32.ge_u
              br_if 2 (;@3;)
              i32.const 268435455
              local.set 7
              block  ;; label = @6
                local.get 2
                local.get 4
                i32.sub
                local.tee 2
                i32.const 4
                i32.shr_s
                i32.const 134217726
                i32.gt_u
                br_if 0 (;@6;)
                local.get 6
                local.get 2
                i32.const 3
                i32.shr_s
                local.tee 7
                local.get 7
                local.get 6
                i32.lt_u
                select
                local.tee 7
                i32.eqz
                br_if 2 (;@4;)
                local.get 7
                i32.const 268435456
                i32.ge_u
                br_if 4 (;@2;)
              end
              local.get 7
              i32.const 4
              i32.shl
              call 55
              local.set 2
              local.get 0
              i32.const 4
              i32.add
              i32.load
              local.set 3
              local.get 0
              i32.load
              local.set 4
              br 4 (;@1;)
            end
            local.get 0
            i32.const 4
            i32.add
            local.get 3
            local.get 1
            i32.const 4
            i32.shl
            i32.add
            i32.store
            return
          end
          i32.const 0
          local.set 7
          i32.const 0
          local.set 2
          br 2 (;@1;)
        end
        local.get 0
        call 59
        unreachable
      end
      call 15
      unreachable
    end
    local.get 2
    local.get 5
    i32.const 4
    i32.shl
    i32.add
    local.tee 6
    local.get 3
    local.get 4
    i32.sub
    local.tee 3
    i32.sub
    local.set 5
    local.get 6
    local.get 1
    i32.const 4
    i32.shl
    i32.add
    local.set 1
    local.get 2
    local.get 7
    i32.const 4
    i32.shl
    i32.add
    local.set 7
    block  ;; label = @1
      local.get 3
      i32.const 1
      i32.lt_s
      br_if 0 (;@1;)
      local.get 5
      local.get 4
      local.get 3
      call 6
      drop
      local.get 0
      i32.load
      local.set 4
    end
    local.get 0
    local.get 5
    i32.store
    local.get 0
    i32.const 4
    i32.add
    local.get 1
    i32.store
    local.get 0
    i32.const 8
    i32.add
    local.get 7
    i32.store
    block  ;; label = @1
      local.get 4
      i32.eqz
      br_if 0 (;@1;)
      local.get 4
      call 57
    end)
  (func (;33;) (type 1) (param i32 i64 i64 i32)
    (local i32 i64 i64 i32 i32 i32)
    global.get 0
    i32.const 64
    i32.sub
    local.tee 4
    global.set 0
    local.get 3
    i64.load
    local.tee 5
    local.get 3
    i64.load offset=8
    local.tee 6
    call 10
    local.get 4
    i32.const 56
    i32.add
    i32.const 0
    i32.store
    local.get 4
    local.get 1
    i64.store offset=32
    local.get 4
    i64.const -1
    i64.store offset=40
    local.get 4
    i64.const 0
    i64.store offset=48
    local.get 4
    local.get 0
    i64.load
    i64.store offset=24
    block  ;; label = @1
      local.get 4
      i32.const 24
      i32.add
      local.get 2
      i32.const 8366
      call 34
      local.tee 7
      i32.load offset=8
      local.tee 0
      local.get 7
      i32.const 12
      i32.add
      i32.load
      local.tee 8
      i32.eq
      br_if 0 (;@1;)
      loop  ;; label = @2
        block  ;; label = @3
          local.get 0
          i64.load
          local.get 5
          i64.ne
          br_if 0 (;@3;)
          local.get 0
          i32.const 8
          i32.add
          i64.load
          local.get 6
          i64.eq
          br_if 2 (;@1;)
        end
        local.get 8
        local.get 0
        i32.const 16
        i32.add
        local.tee 0
        i32.ne
        br_if 0 (;@2;)
      end
      local.get 8
      local.set 0
    end
    local.get 4
    local.get 0
    i32.store offset=16
    local.get 0
    local.get 8
    i32.ne
    i32.const 8385
    call 5
    local.get 4
    local.get 3
    i32.store offset=8
    local.get 4
    local.get 4
    i32.const 16
    i32.add
    i32.store offset=12
    local.get 4
    i32.const 24
    i32.add
    local.get 7
    local.get 1
    local.get 4
    i32.const 8
    i32.add
    call 35
    block  ;; label = @1
      local.get 4
      i32.load offset=48
      local.tee 7
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          i32.const 52
          i32.add
          local.tee 9
          i32.load
          local.tee 8
          local.get 7
          i32.eq
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 8
            i32.const -24
            i32.add
            local.tee 8
            i32.load
            local.set 0
            local.get 8
            i32.const 0
            i32.store
            block  ;; label = @5
              local.get 0
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 0
                i32.load offset=20
                local.tee 3
                i32.eqz
                br_if 0 (;@6;)
                local.get 0
                i32.const 24
                i32.add
                local.get 3
                i32.store
                local.get 3
                call 57
              end
              block  ;; label = @6
                local.get 0
                i32.load offset=8
                local.tee 3
                i32.eqz
                br_if 0 (;@6;)
                local.get 0
                i32.const 12
                i32.add
                local.get 3
                i32.store
                local.get 3
                call 57
              end
              local.get 0
              call 57
            end
            local.get 7
            local.get 8
            i32.ne
            br_if 0 (;@4;)
          end
          local.get 4
          i32.const 48
          i32.add
          i32.load
          local.set 0
          br 1 (;@2;)
        end
        local.get 7
        local.set 0
      end
      local.get 9
      local.get 7
      i32.store
      local.get 0
      call 57
    end
    local.get 4
    i32.const 64
    i32.add
    global.set 0)
  (func (;34;) (type 18) (param i32 i64 i32) (result i32)
    (local i32 i32 i32 i32)
    block  ;; label = @1
      local.get 0
      i32.load offset=24
      local.tee 3
      local.get 0
      i32.const 28
      i32.add
      i32.load
      local.tee 4
      i32.eq
      br_if 0 (;@1;)
      block  ;; label = @2
        loop  ;; label = @3
          local.get 4
          i32.const -24
          i32.add
          local.tee 5
          i32.load
          local.tee 6
          i64.load
          local.get 1
          i64.eq
          br_if 1 (;@2;)
          local.get 5
          local.set 4
          local.get 3
          local.get 5
          i32.ne
          br_if 0 (;@3;)
          br 2 (;@1;)
        end
      end
      local.get 3
      local.get 4
      i32.eq
      br_if 0 (;@1;)
      local.get 6
      i32.load offset=32
      local.get 0
      i32.eq
      i32.const 8577
      call 5
      local.get 6
      i32.const 0
      i32.ne
      local.get 2
      call 5
      local.get 6
      return
    end
    i32.const 0
    local.set 5
    block  ;; label = @1
      local.get 0
      i64.load
      local.get 0
      i64.load offset=8
      i64.const 3849304914312298496
      local.get 1
      call 8
      local.tee 4
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      local.get 0
      local.get 4
      call 36
      local.tee 5
      i32.load offset=32
      local.get 0
      i32.eq
      i32.const 8577
      call 5
    end
    local.get 5
    i32.const 0
    i32.ne
    local.get 2
    call 5
    local.get 5)
  (func (;35;) (type 19) (param i32 i32 i64 i32)
    (local i32 i32 i32 i64 i32 i32 i32 i32 i64)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 4
    local.set 5
    local.get 4
    global.set 0
    local.get 1
    i32.load offset=32
    local.get 0
    i32.eq
    i32.const 8702
    call 5
    local.get 0
    i64.load
    call 9
    i64.eq
    i32.const 8748
    call 5
    local.get 3
    i32.load
    local.set 6
    local.get 1
    i64.load
    local.set 7
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 24
        i32.add
        local.tee 8
        i32.load
        local.tee 9
        local.get 1
        i32.const 28
        i32.add
        i32.load
        i32.eq
        br_if 0 (;@2;)
        local.get 9
        local.get 6
        i64.load
        i64.store
        local.get 9
        i32.const 8
        i32.add
        local.get 6
        i32.const 8
        i32.add
        i64.load
        i64.store
        local.get 8
        local.get 8
        i32.load
        i32.const 16
        i32.add
        i32.store
        br 1 (;@1;)
      end
      local.get 1
      i32.const 20
      i32.add
      local.get 6
      call 37
    end
    local.get 1
    i32.const 12
    i32.add
    local.tee 6
    i32.load
    local.get 3
    i32.load offset=4
    i32.load
    local.tee 3
    i32.const 16
    i32.add
    local.tee 10
    i32.sub
    local.tee 8
    i32.const 4
    i32.shr_s
    local.set 9
    block  ;; label = @1
      local.get 8
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      local.get 10
      local.get 8
      call 11
      drop
    end
    local.get 6
    local.get 3
    local.get 9
    i32.const 4
    i32.shl
    i32.add
    i32.store
    local.get 7
    local.get 1
    i64.load
    i64.eq
    i32.const 8799
    call 5
    i32.const 8
    local.set 3
    local.get 1
    i32.const 8
    i32.add
    local.set 9
    local.get 6
    i32.load
    local.tee 6
    local.get 1
    i32.load offset=8
    local.tee 10
    i32.sub
    local.tee 11
    i32.const 4
    i32.shr_s
    i64.extend_i32_u
    local.set 12
    loop  ;; label = @1
      local.get 3
      i32.const 1
      i32.add
      local.set 3
      local.get 12
      i64.const 7
      i64.shr_u
      local.tee 12
      i64.const 0
      i64.ne
      br_if 0 (;@1;)
    end
    local.get 1
    i32.const 20
    i32.add
    local.set 8
    block  ;; label = @1
      local.get 10
      local.get 6
      i32.eq
      br_if 0 (;@1;)
      local.get 11
      i32.const -16
      i32.and
      local.get 3
      i32.add
      local.set 3
    end
    local.get 1
    i32.const 24
    i32.add
    i32.load
    local.tee 6
    local.get 8
    i32.load
    local.tee 10
    i32.sub
    local.tee 11
    i32.const 4
    i32.shr_s
    i64.extend_i32_u
    local.set 12
    loop  ;; label = @1
      local.get 3
      i32.const 1
      i32.add
      local.set 3
      local.get 12
      i64.const 7
      i64.shr_u
      local.tee 12
      i64.const 0
      i64.ne
      br_if 0 (;@1;)
    end
    block  ;; label = @1
      local.get 10
      local.get 6
      i32.eq
      br_if 0 (;@1;)
      local.get 11
      i32.const -16
      i32.and
      local.get 3
      i32.add
      local.set 3
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        i32.const 513
        i32.lt_u
        br_if 0 (;@2;)
        local.get 3
        call 51
        local.set 6
        br 1 (;@1;)
      end
      local.get 4
      local.get 3
      i32.const 15
      i32.add
      i32.const -16
      i32.and
      i32.sub
      local.tee 6
      global.set 0
    end
    local.get 5
    local.get 6
    i32.store
    local.get 5
    local.get 6
    local.get 3
    i32.add
    i32.store offset=8
    local.get 3
    i32.const 7
    i32.gt_s
    i32.const 8562
    call 5
    local.get 6
    local.get 1
    i32.const 8
    call 6
    drop
    local.get 5
    local.get 6
    i32.const 8
    i32.add
    i32.store offset=4
    local.get 5
    local.get 9
    call 27
    drop
    local.get 5
    local.get 8
    call 27
    drop
    local.get 1
    i32.load offset=36
    local.get 2
    local.get 6
    local.get 3
    call 12
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 513
          i32.ge_u
          br_if 0 (;@3;)
          local.get 7
          local.get 0
          i64.load offset=16
          i64.ge_u
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 6
        call 54
        local.get 7
        local.get 0
        i64.load offset=16
        i64.lt_u
        br_if 1 (;@1;)
      end
      local.get 0
      i32.const 16
      i32.add
      i64.const -2
      local.get 7
      i64.const 1
      i64.add
      local.get 7
      i64.const -3
      i64.gt_u
      select
      i64.store
      local.get 5
      i32.const 16
      i32.add
      global.set 0
      return
    end
    local.get 5
    i32.const 16
    i32.add
    global.set 0)
  (func (;36;) (type 7) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i64)
    global.get 0
    i32.const 48
    i32.sub
    local.tee 2
    local.set 3
    local.get 2
    global.set 0
    block  ;; label = @1
      local.get 0
      i32.load offset=24
      local.tee 4
      local.get 0
      i32.const 28
      i32.add
      i32.load
      local.tee 5
      i32.eq
      br_if 0 (;@1;)
      block  ;; label = @2
        loop  ;; label = @3
          local.get 5
          i32.const -8
          i32.add
          i32.load
          local.get 1
          i32.eq
          br_if 1 (;@2;)
          local.get 4
          local.get 5
          i32.const -24
          i32.add
          local.tee 5
          i32.ne
          br_if 0 (;@3;)
          br 2 (;@1;)
        end
      end
      local.get 4
      local.get 5
      i32.eq
      br_if 0 (;@1;)
      local.get 5
      i32.const -24
      i32.add
      i32.load
      local.set 5
      local.get 3
      i32.const 48
      i32.add
      global.set 0
      local.get 5
      return
    end
    local.get 1
    i32.const 0
    i32.const 0
    call 16
    local.tee 5
    i32.const 31
    i32.shr_u
    i32.const 1
    i32.xor
    i32.const 8628
    call 5
    block  ;; label = @1
      block  ;; label = @2
        local.get 5
        i32.const 513
        i32.lt_u
        br_if 0 (;@2;)
        local.get 5
        call 51
        local.set 4
        br 1 (;@1;)
      end
      local.get 2
      local.get 5
      i32.const 15
      i32.add
      i32.const -16
      i32.and
      i32.sub
      local.tee 4
      global.set 0
    end
    local.get 1
    local.get 4
    local.get 5
    call 16
    drop
    local.get 3
    local.get 4
    i32.store offset=36
    local.get 3
    local.get 4
    i32.store offset=32
    local.get 3
    local.get 4
    local.get 5
    i32.add
    local.tee 2
    i32.store offset=40
    block  ;; label = @1
      local.get 5
      i32.const 512
      i32.le_u
      br_if 0 (;@1;)
      local.get 4
      call 54
      local.get 3
      i32.const 40
      i32.add
      i32.load
      local.set 2
      local.get 3
      i32.load offset=36
      local.set 4
    end
    i32.const 48
    call 55
    local.tee 5
    i64.const 0
    i64.store
    local.get 5
    i64.const 0
    i64.store offset=8 align=4
    local.get 5
    i64.const 0
    i64.store offset=16 align=4
    local.get 5
    i64.const 0
    i64.store offset=24 align=4
    local.get 5
    local.get 0
    i32.store offset=32
    local.get 2
    local.get 4
    i32.sub
    i32.const 7
    i32.gt_u
    i32.const 8568
    call 5
    local.get 5
    local.get 4
    i32.const 8
    call 6
    drop
    local.get 3
    local.get 4
    i32.const 8
    i32.add
    i32.store offset=36
    local.get 3
    i32.const 32
    i32.add
    local.get 5
    i32.const 8
    i32.add
    call 24
    drop
    local.get 3
    i32.const 32
    i32.add
    local.get 5
    i32.const 20
    i32.add
    call 24
    drop
    local.get 5
    local.get 1
    i32.store offset=36
    local.get 3
    local.get 5
    i32.store offset=24
    local.get 3
    local.get 5
    i64.load
    local.tee 6
    i64.store offset=16
    local.get 3
    local.get 1
    i32.store offset=12
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.const 28
          i32.add
          local.tee 2
          i32.load
          local.tee 4
          local.get 0
          i32.const 32
          i32.add
          i32.load
          i32.ge_u
          br_if 0 (;@3;)
          local.get 4
          local.get 6
          i64.store offset=8
          local.get 4
          local.get 1
          i32.store offset=16
          local.get 3
          i32.const 0
          i32.store offset=24
          local.get 4
          local.get 5
          i32.store
          local.get 2
          local.get 4
          i32.const 24
          i32.add
          i32.store
          local.get 3
          i32.load offset=24
          local.set 1
          local.get 3
          i32.const 0
          i32.store offset=24
          local.get 1
          i32.eqz
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 0
        i32.const 24
        i32.add
        local.get 3
        i32.const 24
        i32.add
        local.get 3
        i32.const 16
        i32.add
        local.get 3
        i32.const 12
        i32.add
        call 31
        local.get 3
        i32.load offset=24
        local.set 1
        local.get 3
        i32.const 0
        i32.store offset=24
        local.get 1
        br_if 1 (;@1;)
      end
      local.get 3
      i32.const 48
      i32.add
      global.set 0
      local.get 5
      return
    end
    block  ;; label = @1
      local.get 1
      i32.load offset=20
      local.tee 4
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.const 24
      i32.add
      local.get 4
      i32.store
      local.get 4
      call 57
    end
    block  ;; label = @1
      local.get 1
      i32.load offset=8
      local.tee 4
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.const 12
      i32.add
      local.get 4
      i32.store
      local.get 4
      call 57
    end
    local.get 1
    call 57
    local.get 3
    i32.const 48
    i32.add
    global.set 0
    local.get 5)
  (func (;37;) (type 9) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.load offset=4
          local.tee 2
          local.get 0
          i32.load
          local.tee 3
          i32.sub
          i32.const 4
          i32.shr_s
          local.tee 4
          i32.const 1
          i32.add
          local.tee 5
          i32.const 268435456
          i32.ge_u
          br_if 0 (;@3;)
          i32.const 268435455
          local.set 6
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load offset=8
              local.get 3
              i32.sub
              local.tee 7
              i32.const 4
              i32.shr_s
              i32.const 134217726
              i32.gt_u
              br_if 0 (;@5;)
              local.get 5
              local.get 7
              i32.const 3
              i32.shr_s
              local.tee 6
              local.get 6
              local.get 5
              i32.lt_u
              select
              local.tee 6
              i32.eqz
              br_if 1 (;@4;)
              local.get 6
              i32.const 268435456
              i32.ge_u
              br_if 3 (;@2;)
            end
            local.get 6
            i32.const 4
            i32.shl
            call 55
            local.set 5
            local.get 0
            i32.const 4
            i32.add
            i32.load
            local.set 2
            local.get 0
            i32.load
            local.set 3
            br 3 (;@1;)
          end
          i32.const 0
          local.set 6
          i32.const 0
          local.set 5
          br 2 (;@1;)
        end
        local.get 0
        call 59
        unreachable
      end
      call 15
      unreachable
    end
    local.get 5
    local.get 4
    i32.const 4
    i32.shl
    i32.add
    local.tee 4
    local.get 1
    i64.load
    i64.store
    local.get 4
    i32.const 8
    i32.add
    local.get 1
    i32.const 8
    i32.add
    i64.load
    i64.store
    local.get 4
    local.get 2
    local.get 3
    i32.sub
    local.tee 1
    i32.sub
    local.set 2
    local.get 5
    local.get 6
    i32.const 4
    i32.shl
    i32.add
    local.set 6
    local.get 4
    i32.const 16
    i32.add
    local.set 4
    block  ;; label = @1
      local.get 1
      i32.const 1
      i32.lt_s
      br_if 0 (;@1;)
      local.get 2
      local.get 3
      local.get 1
      call 6
      drop
      local.get 0
      i32.load
      local.set 3
    end
    local.get 0
    local.get 2
    i32.store
    local.get 0
    i32.const 4
    i32.add
    local.get 4
    i32.store
    local.get 0
    i32.const 8
    i32.add
    local.get 6
    i32.store
    block  ;; label = @1
      local.get 3
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      call 57
    end)
  (func (;38;) (type 1) (param i32 i64 i64 i32)
    (local i32 i64 i64 i32 i32 i32)
    global.get 0
    i32.const 64
    i32.sub
    local.tee 4
    global.set 0
    local.get 3
    i64.load
    local.tee 5
    local.get 3
    i64.load offset=8
    local.tee 6
    call 10
    local.get 4
    i32.const 56
    i32.add
    i32.const 0
    i32.store
    local.get 4
    local.get 1
    i64.store offset=32
    local.get 4
    i64.const -1
    i64.store offset=40
    local.get 4
    i64.const 0
    i64.store offset=48
    local.get 4
    local.get 0
    i64.load
    i64.store offset=24
    block  ;; label = @1
      local.get 4
      i32.const 24
      i32.add
      local.get 2
      i32.const 8366
      call 34
      local.tee 7
      i32.load offset=20
      local.tee 0
      local.get 7
      i32.const 24
      i32.add
      i32.load
      local.tee 8
      i32.eq
      br_if 0 (;@1;)
      loop  ;; label = @2
        block  ;; label = @3
          local.get 0
          i64.load
          local.get 5
          i64.ne
          br_if 0 (;@3;)
          local.get 0
          i32.const 8
          i32.add
          i64.load
          local.get 6
          i64.eq
          br_if 2 (;@1;)
        end
        local.get 8
        local.get 0
        i32.const 16
        i32.add
        local.tee 0
        i32.ne
        br_if 0 (;@2;)
      end
      local.get 8
      local.set 0
    end
    local.get 4
    local.get 0
    i32.store offset=16
    local.get 0
    local.get 8
    i32.ne
    i32.const 8436
    call 5
    local.get 4
    local.get 3
    i32.store offset=8
    local.get 4
    local.get 4
    i32.const 16
    i32.add
    i32.store offset=12
    local.get 4
    i32.const 24
    i32.add
    local.get 7
    local.get 1
    local.get 4
    i32.const 8
    i32.add
    call 39
    block  ;; label = @1
      local.get 4
      i32.load offset=48
      local.tee 7
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          i32.const 52
          i32.add
          local.tee 9
          i32.load
          local.tee 8
          local.get 7
          i32.eq
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 8
            i32.const -24
            i32.add
            local.tee 8
            i32.load
            local.set 0
            local.get 8
            i32.const 0
            i32.store
            block  ;; label = @5
              local.get 0
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 0
                i32.load offset=20
                local.tee 3
                i32.eqz
                br_if 0 (;@6;)
                local.get 0
                i32.const 24
                i32.add
                local.get 3
                i32.store
                local.get 3
                call 57
              end
              block  ;; label = @6
                local.get 0
                i32.load offset=8
                local.tee 3
                i32.eqz
                br_if 0 (;@6;)
                local.get 0
                i32.const 12
                i32.add
                local.get 3
                i32.store
                local.get 3
                call 57
              end
              local.get 0
              call 57
            end
            local.get 7
            local.get 8
            i32.ne
            br_if 0 (;@4;)
          end
          local.get 4
          i32.const 48
          i32.add
          i32.load
          local.set 0
          br 1 (;@2;)
        end
        local.get 7
        local.set 0
      end
      local.get 9
      local.get 7
      i32.store
      local.get 0
      call 57
    end
    local.get 4
    i32.const 64
    i32.add
    global.set 0)
  (func (;39;) (type 19) (param i32 i32 i64 i32)
    (local i32 i32 i32 i64 i32 i32 i32 i32 i64)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 4
    local.set 5
    local.get 4
    global.set 0
    local.get 1
    i32.load offset=32
    local.get 0
    i32.eq
    i32.const 8702
    call 5
    local.get 0
    i64.load
    call 9
    i64.eq
    i32.const 8748
    call 5
    local.get 3
    i32.load
    local.set 6
    local.get 1
    i64.load
    local.set 7
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 12
        i32.add
        local.tee 8
        i32.load
        local.tee 9
        local.get 1
        i32.const 16
        i32.add
        i32.load
        i32.eq
        br_if 0 (;@2;)
        local.get 9
        local.get 6
        i64.load
        i64.store
        local.get 9
        i32.const 8
        i32.add
        local.get 6
        i32.const 8
        i32.add
        i64.load
        i64.store
        local.get 8
        local.get 8
        i32.load
        i32.const 16
        i32.add
        i32.store
        br 1 (;@1;)
      end
      local.get 1
      i32.const 8
      i32.add
      local.get 6
      call 37
    end
    local.get 1
    i32.const 24
    i32.add
    local.tee 8
    i32.load
    local.get 3
    i32.load offset=4
    i32.load
    local.tee 3
    i32.const 16
    i32.add
    local.tee 10
    i32.sub
    local.tee 6
    i32.const 4
    i32.shr_s
    local.set 9
    block  ;; label = @1
      local.get 6
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      local.get 10
      local.get 6
      call 11
      drop
    end
    local.get 8
    local.get 3
    local.get 9
    i32.const 4
    i32.shl
    i32.add
    i32.store
    local.get 7
    local.get 1
    i64.load
    i64.eq
    i32.const 8799
    call 5
    i32.const 8
    local.set 3
    local.get 1
    i32.const 8
    i32.add
    local.set 9
    local.get 1
    i32.const 12
    i32.add
    i32.load
    local.tee 6
    local.get 1
    i32.load offset=8
    local.tee 10
    i32.sub
    local.tee 11
    i32.const 4
    i32.shr_s
    i64.extend_i32_u
    local.set 12
    loop  ;; label = @1
      local.get 3
      i32.const 1
      i32.add
      local.set 3
      local.get 12
      i64.const 7
      i64.shr_u
      local.tee 12
      i64.const 0
      i64.ne
      br_if 0 (;@1;)
    end
    local.get 1
    i32.const 20
    i32.add
    local.set 8
    block  ;; label = @1
      local.get 10
      local.get 6
      i32.eq
      br_if 0 (;@1;)
      local.get 11
      i32.const -16
      i32.and
      local.get 3
      i32.add
      local.set 3
    end
    local.get 1
    i32.const 24
    i32.add
    i32.load
    local.tee 6
    local.get 8
    i32.load
    local.tee 10
    i32.sub
    local.tee 11
    i32.const 4
    i32.shr_s
    i64.extend_i32_u
    local.set 12
    loop  ;; label = @1
      local.get 3
      i32.const 1
      i32.add
      local.set 3
      local.get 12
      i64.const 7
      i64.shr_u
      local.tee 12
      i64.const 0
      i64.ne
      br_if 0 (;@1;)
    end
    block  ;; label = @1
      local.get 10
      local.get 6
      i32.eq
      br_if 0 (;@1;)
      local.get 11
      i32.const -16
      i32.and
      local.get 3
      i32.add
      local.set 3
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        i32.const 513
        i32.lt_u
        br_if 0 (;@2;)
        local.get 3
        call 51
        local.set 6
        br 1 (;@1;)
      end
      local.get 4
      local.get 3
      i32.const 15
      i32.add
      i32.const -16
      i32.and
      i32.sub
      local.tee 6
      global.set 0
    end
    local.get 5
    local.get 6
    i32.store
    local.get 5
    local.get 6
    local.get 3
    i32.add
    i32.store offset=8
    local.get 3
    i32.const 7
    i32.gt_s
    i32.const 8562
    call 5
    local.get 6
    local.get 1
    i32.const 8
    call 6
    drop
    local.get 5
    local.get 6
    i32.const 8
    i32.add
    i32.store offset=4
    local.get 5
    local.get 9
    call 27
    drop
    local.get 5
    local.get 8
    call 27
    drop
    local.get 1
    i32.load offset=36
    local.get 2
    local.get 6
    local.get 3
    call 12
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 513
          i32.ge_u
          br_if 0 (;@3;)
          local.get 7
          local.get 0
          i64.load offset=16
          i64.ge_u
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 6
        call 54
        local.get 7
        local.get 0
        i64.load offset=16
        i64.lt_u
        br_if 1 (;@1;)
      end
      local.get 0
      i32.const 16
      i32.add
      i64.const -2
      local.get 7
      i64.const 1
      i64.add
      local.get 7
      i64.const -3
      i64.gt_u
      select
      i64.store
      local.get 5
      i32.const 16
      i32.add
      global.set 0
      return
    end
    local.get 5
    i32.const 16
    i32.add
    global.set 0)
  (func (;40;) (type 0) (param i32 i64 i64 i64)
    (local i32 i32 i32 i32 i32)
    global.get 0
    i32.const 96
    i32.sub
    local.tee 4
    global.set 0
    local.get 3
    call 7
    local.get 4
    i32.const 40
    i32.add
    i32.const 32
    i32.add
    i32.const 0
    i32.store
    local.get 4
    local.get 1
    i64.store offset=48
    local.get 4
    i64.const -1
    i64.store offset=56
    local.get 4
    i64.const 0
    i64.store offset=64
    local.get 4
    local.get 0
    i64.load
    i64.store offset=40
    local.get 4
    i32.const 40
    i32.add
    local.get 2
    i32.const 8366
    call 41
    local.set 5
    block  ;; label = @1
      local.get 3
      local.get 1
      i64.eq
      br_if 0 (;@1;)
      local.get 5
      i32.const 12
      i32.add
      i32.load
      local.set 6
      local.get 5
      i32.load offset=8
      local.set 7
      call 4
      local.set 3
      local.get 4
      i32.const 0
      i32.store offset=12
      local.get 4
      i32.const 0
      i32.store8 offset=16
      local.get 4
      i32.const 0
      i32.store offset=20
      local.get 4
      local.get 3
      i64.const 1000000
      i64.div_u
      i32.wrap_i64
      i32.const 60
      i32.add
      i32.store
      local.get 4
      local.get 7
      i32.store offset=84
      local.get 4
      local.get 7
      i32.store offset=80
      local.get 4
      local.get 6
      i32.store offset=88
      local.get 4
      i32.const 80
      i32.add
      local.get 4
      call 25
      drop
      call 4
      local.set 3
      local.get 4
      i32.load
      local.get 3
      i64.const 1000000
      i64.div_u
      i32.wrap_i64
      i32.lt_u
      i32.const 8467
      call 5
    end
    local.get 4
    i32.const 32
    i32.add
    i32.const 0
    i32.store
    local.get 4
    local.get 1
    i64.store offset=8
    local.get 4
    i64.const -1
    i64.store offset=16
    local.get 4
    i64.const 0
    i64.store offset=24
    local.get 4
    local.get 0
    i64.load
    i64.store
    local.get 4
    local.get 2
    i32.const 8366
    call 34
    local.set 0
    local.get 4
    i32.const 40
    i32.add
    local.get 5
    call 42
    local.get 4
    local.get 0
    call 43
    block  ;; label = @1
      local.get 4
      i32.load offset=24
      local.tee 6
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          i32.const 28
          i32.add
          local.tee 8
          i32.load
          local.tee 5
          local.get 6
          i32.eq
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 5
            i32.const -24
            i32.add
            local.tee 5
            i32.load
            local.set 0
            local.get 5
            i32.const 0
            i32.store
            block  ;; label = @5
              local.get 0
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 0
                i32.load offset=20
                local.tee 7
                i32.eqz
                br_if 0 (;@6;)
                local.get 0
                i32.const 24
                i32.add
                local.get 7
                i32.store
                local.get 7
                call 57
              end
              block  ;; label = @6
                local.get 0
                i32.load offset=8
                local.tee 7
                i32.eqz
                br_if 0 (;@6;)
                local.get 0
                i32.const 12
                i32.add
                local.get 7
                i32.store
                local.get 7
                call 57
              end
              local.get 0
              call 57
            end
            local.get 6
            local.get 5
            i32.ne
            br_if 0 (;@4;)
          end
          local.get 4
          i32.const 24
          i32.add
          i32.load
          local.set 0
          br 1 (;@2;)
        end
        local.get 6
        local.set 0
      end
      local.get 8
      local.get 6
      i32.store
      local.get 0
      call 57
    end
    block  ;; label = @1
      local.get 4
      i32.load offset=64
      local.tee 6
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          i32.const 68
          i32.add
          local.tee 8
          i32.load
          local.tee 0
          local.get 6
          i32.eq
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 0
            i32.const -24
            i32.add
            local.tee 0
            i32.load
            local.set 5
            local.get 0
            i32.const 0
            i32.store
            block  ;; label = @5
              local.get 5
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 5
                i32.load offset=8
                local.tee 7
                i32.eqz
                br_if 0 (;@6;)
                local.get 5
                i32.const 12
                i32.add
                local.get 7
                i32.store
                local.get 7
                call 57
              end
              local.get 5
              call 57
            end
            local.get 6
            local.get 0
            i32.ne
            br_if 0 (;@4;)
          end
          local.get 4
          i32.const 64
          i32.add
          i32.load
          local.set 0
          br 1 (;@2;)
        end
        local.get 6
        local.set 0
      end
      local.get 8
      local.get 6
      i32.store
      local.get 0
      call 57
    end
    local.get 4
    i32.const 96
    i32.add
    global.set 0)
  (func (;41;) (type 18) (param i32 i64 i32) (result i32)
    (local i32 i32 i32 i32)
    block  ;; label = @1
      local.get 0
      i32.load offset=24
      local.tee 3
      local.get 0
      i32.const 28
      i32.add
      i32.load
      local.tee 4
      i32.eq
      br_if 0 (;@1;)
      block  ;; label = @2
        loop  ;; label = @3
          local.get 4
          i32.const -24
          i32.add
          local.tee 5
          i32.load
          local.tee 6
          i64.load
          local.get 1
          i64.eq
          br_if 1 (;@2;)
          local.get 5
          local.set 4
          local.get 3
          local.get 5
          i32.ne
          br_if 0 (;@3;)
          br 2 (;@1;)
        end
      end
      local.get 3
      local.get 4
      i32.eq
      br_if 0 (;@1;)
      local.get 6
      i32.load offset=20
      local.get 0
      i32.eq
      i32.const 8577
      call 5
      local.get 6
      i32.const 0
      i32.ne
      local.get 2
      call 5
      local.get 6
      return
    end
    i32.const 0
    local.set 5
    block  ;; label = @1
      local.get 0
      i64.load
      local.get 0
      i64.load offset=8
      i64.const -5915097263704637440
      local.get 1
      call 8
      local.tee 4
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      local.get 0
      local.get 4
      call 26
      local.tee 5
      i32.load offset=20
      local.get 0
      i32.eq
      i32.const 8577
      call 5
    end
    local.get 5
    i32.const 0
    i32.ne
    local.get 2
    call 5
    local.get 5)
  (func (;42;) (type 9) (param i32 i32)
    (local i32 i32 i32 i32 i64 i32 i32)
    local.get 1
    i32.load offset=20
    local.get 0
    i32.eq
    i32.const 8858
    call 5
    local.get 0
    i64.load
    call 9
    i64.eq
    i32.const 8903
    call 5
    local.get 0
    i32.load offset=24
    local.tee 2
    local.set 3
    block  ;; label = @1
      local.get 2
      local.get 0
      i32.const 28
      i32.add
      local.tee 4
      i32.load
      local.tee 5
      i32.eq
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 5
        i32.const -24
        i32.add
        i32.load
        i64.load
        local.get 1
        i64.load
        local.tee 6
        i64.ne
        br_if 0 (;@2;)
        local.get 5
        local.set 3
        br 1 (;@1;)
      end
      local.get 2
      i32.const 24
      i32.add
      local.set 7
      block  ;; label = @2
        loop  ;; label = @3
          local.get 7
          local.get 5
          i32.eq
          br_if 1 (;@2;)
          local.get 5
          i32.const -48
          i32.add
          local.set 8
          local.get 5
          i32.const -24
          i32.add
          local.tee 3
          local.set 5
          local.get 8
          i32.load
          i64.load
          local.get 6
          i64.ne
          br_if 0 (;@3;)
          br 2 (;@1;)
        end
      end
      local.get 2
      local.set 3
    end
    local.get 3
    local.get 2
    i32.ne
    i32.const 8953
    call 5
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          local.get 4
          i32.load
          local.tee 2
          i32.eq
          br_if 0 (;@3;)
          local.get 3
          local.set 5
          loop  ;; label = @4
            local.get 5
            i32.load
            local.set 8
            local.get 5
            i32.const 0
            i32.store
            local.get 5
            i32.const -24
            i32.add
            local.tee 7
            i32.load
            local.set 3
            local.get 7
            local.get 8
            i32.store
            block  ;; label = @5
              local.get 3
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 3
                i32.load offset=8
                local.tee 8
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.const 12
                i32.add
                local.get 8
                i32.store
                local.get 8
                call 57
              end
              local.get 3
              call 57
            end
            local.get 5
            i32.const -8
            i32.add
            local.get 5
            i32.const 16
            i32.add
            i32.load
            i32.store
            local.get 5
            i32.const -16
            i32.add
            local.get 5
            i32.const 8
            i32.add
            i64.load
            i64.store
            local.get 2
            local.get 5
            i32.const 24
            i32.add
            local.tee 5
            i32.ne
            br_if 0 (;@4;)
          end
          local.get 5
          i32.const -24
          i32.add
          local.set 7
          local.get 0
          i32.const 28
          i32.add
          i32.load
          local.tee 3
          i32.const 24
          i32.add
          local.get 5
          i32.ne
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 3
        i32.const -24
        i32.add
        local.set 7
      end
      loop  ;; label = @2
        local.get 3
        i32.const -24
        i32.add
        local.tee 3
        i32.load
        local.set 5
        local.get 3
        i32.const 0
        i32.store
        block  ;; label = @3
          local.get 5
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 5
            i32.load offset=8
            local.tee 8
            i32.eqz
            br_if 0 (;@4;)
            local.get 5
            i32.const 12
            i32.add
            local.get 8
            i32.store
            local.get 8
            call 57
          end
          local.get 5
          call 57
        end
        local.get 7
        local.get 3
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 0
    i32.const 28
    i32.add
    local.get 7
    i32.store
    local.get 1
    i32.load offset=24
    call 13)
  (func (;43;) (type 9) (param i32 i32)
    (local i32 i32 i32 i32 i64 i32 i32)
    local.get 1
    i32.load offset=32
    local.get 0
    i32.eq
    i32.const 8858
    call 5
    local.get 0
    i64.load
    call 9
    i64.eq
    i32.const 8903
    call 5
    local.get 0
    i32.load offset=24
    local.tee 2
    local.set 3
    block  ;; label = @1
      local.get 2
      local.get 0
      i32.const 28
      i32.add
      local.tee 4
      i32.load
      local.tee 5
      i32.eq
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 5
        i32.const -24
        i32.add
        i32.load
        i64.load
        local.get 1
        i64.load
        local.tee 6
        i64.ne
        br_if 0 (;@2;)
        local.get 5
        local.set 3
        br 1 (;@1;)
      end
      local.get 2
      i32.const 24
      i32.add
      local.set 7
      block  ;; label = @2
        loop  ;; label = @3
          local.get 7
          local.get 5
          i32.eq
          br_if 1 (;@2;)
          local.get 5
          i32.const -48
          i32.add
          local.set 8
          local.get 5
          i32.const -24
          i32.add
          local.tee 3
          local.set 5
          local.get 8
          i32.load
          i64.load
          local.get 6
          i64.ne
          br_if 0 (;@3;)
          br 2 (;@1;)
        end
      end
      local.get 2
      local.set 3
    end
    local.get 3
    local.get 2
    i32.ne
    i32.const 8953
    call 5
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          local.get 4
          i32.load
          local.tee 2
          i32.eq
          br_if 0 (;@3;)
          local.get 3
          local.set 5
          loop  ;; label = @4
            local.get 5
            i32.load
            local.set 8
            local.get 5
            i32.const 0
            i32.store
            local.get 5
            i32.const -24
            i32.add
            local.tee 7
            i32.load
            local.set 3
            local.get 7
            local.get 8
            i32.store
            block  ;; label = @5
              local.get 3
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 3
                i32.load offset=20
                local.tee 8
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.const 24
                i32.add
                local.get 8
                i32.store
                local.get 8
                call 57
              end
              block  ;; label = @6
                local.get 3
                i32.load offset=8
                local.tee 8
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.const 12
                i32.add
                local.get 8
                i32.store
                local.get 8
                call 57
              end
              local.get 3
              call 57
            end
            local.get 5
            i32.const -8
            i32.add
            local.get 5
            i32.const 16
            i32.add
            i32.load
            i32.store
            local.get 5
            i32.const -16
            i32.add
            local.get 5
            i32.const 8
            i32.add
            i64.load
            i64.store
            local.get 2
            local.get 5
            i32.const 24
            i32.add
            local.tee 5
            i32.ne
            br_if 0 (;@4;)
          end
          local.get 5
          i32.const -24
          i32.add
          local.set 7
          local.get 0
          i32.const 28
          i32.add
          i32.load
          local.tee 3
          i32.const 24
          i32.add
          local.get 5
          i32.ne
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 3
        i32.const -24
        i32.add
        local.set 7
      end
      loop  ;; label = @2
        local.get 3
        i32.const -24
        i32.add
        local.tee 3
        i32.load
        local.set 5
        local.get 3
        i32.const 0
        i32.store
        block  ;; label = @3
          local.get 5
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 5
            i32.load offset=20
            local.tee 8
            i32.eqz
            br_if 0 (;@4;)
            local.get 5
            i32.const 24
            i32.add
            local.get 8
            i32.store
            local.get 8
            call 57
          end
          block  ;; label = @4
            local.get 5
            i32.load offset=8
            local.tee 8
            i32.eqz
            br_if 0 (;@4;)
            local.get 5
            i32.const 12
            i32.add
            local.get 8
            i32.store
            local.get 8
            call 57
          end
          local.get 5
          call 57
        end
        local.get 7
        local.get 3
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 0
    i32.const 28
    i32.add
    local.get 7
    i32.store
    local.get 1
    i32.load offset=36
    call 13)
  (func (;44;) (type 0) (param i32 i64 i64 i64)
    (local i32 i32 i32 i64 i32 i32 i32 i32)
    global.get 0
    i32.const 160
    i32.sub
    local.tee 4
    global.set 0
    local.get 3
    call 7
    i32.const 0
    local.set 5
    local.get 4
    i32.const 120
    i32.add
    i32.const 32
    i32.add
    i32.const 0
    i32.store
    local.get 4
    local.get 1
    i64.store offset=128
    local.get 4
    i64.const -1
    i64.store offset=136
    local.get 4
    i64.const 0
    i64.store offset=144
    local.get 4
    local.get 0
    i64.load
    i64.store offset=120
    local.get 4
    i32.const 120
    i32.add
    local.get 2
    i32.const 8366
    call 41
    local.set 6
    local.get 4
    i32.const 80
    i32.add
    i32.const 32
    i32.add
    i32.const 0
    i32.store
    local.get 4
    local.get 1
    i64.store offset=88
    local.get 4
    i64.const -1
    i64.store offset=96
    local.get 4
    i64.const 0
    i64.store offset=104
    local.get 4
    local.get 0
    i64.load
    i64.store offset=80
    local.get 4
    i32.const 80
    i32.add
    local.get 2
    i32.const 8366
    call 34
    local.set 0
    call 4
    local.set 7
    local.get 4
    i32.const 0
    i32.store offset=68
    local.get 4
    i32.const 0
    i32.store8 offset=72
    local.get 4
    i32.const 0
    i32.store offset=76
    local.get 4
    local.get 7
    i64.const 1000000
    i64.div_u
    i32.wrap_i64
    i32.const 60
    i32.add
    i32.store offset=56
    local.get 4
    local.get 6
    i32.load offset=8
    local.tee 8
    i32.store offset=40
    local.get 4
    local.get 8
    i32.store offset=44
    local.get 4
    local.get 6
    i32.const 12
    i32.add
    i32.load
    i32.store offset=48
    local.get 4
    i32.const 40
    i32.add
    local.get 4
    i32.const 56
    i32.add
    call 25
    drop
    call 4
    local.set 7
    local.get 4
    i32.load offset=56
    local.get 7
    i64.const 1000000
    i64.div_u
    i32.wrap_i64
    i32.ge_u
    i32.const 8192
    call 5
    local.get 4
    i32.const 0
    i32.store offset=32
    local.get 4
    i64.const 0
    i64.store offset=24
    local.get 0
    i32.const 24
    i32.add
    i32.load
    local.tee 8
    local.get 0
    i32.load offset=20
    local.tee 9
    i32.sub
    local.tee 10
    i32.const 4
    i32.shr_s
    i64.extend_i32_u
    local.set 7
    local.get 0
    i32.const 20
    i32.add
    local.set 11
    loop  ;; label = @1
      local.get 5
      i32.const -1
      i32.add
      local.set 5
      local.get 7
      i64.const 7
      i64.shr_u
      local.tee 7
      i64.const 0
      i64.ne
      br_if 0 (;@1;)
    end
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 9
            local.get 8
            i32.eq
            br_if 0 (;@4;)
            local.get 10
            i32.const -16
            i32.and
            local.tee 8
            local.get 5
            i32.ne
            br_if 1 (;@3;)
            i32.const 0
            local.set 8
            i32.const 0
            local.set 5
            br 3 (;@1;)
          end
          i32.const 0
          local.get 5
          i32.sub
          local.set 5
          br 1 (;@2;)
        end
        local.get 8
        local.get 5
        i32.sub
        local.set 5
      end
      local.get 4
      i32.const 24
      i32.add
      local.get 5
      call 22
      local.get 4
      i32.load offset=28
      local.set 8
      local.get 4
      i32.load offset=24
      local.set 5
    end
    local.get 4
    local.get 5
    i32.store offset=4
    local.get 4
    local.get 5
    i32.store
    local.get 4
    local.get 8
    i32.store offset=8
    local.get 4
    local.get 11
    call 27
    drop
    local.get 6
    i32.const 8
    i32.add
    local.tee 5
    i32.load
    local.tee 8
    local.get 6
    i32.const 12
    i32.add
    local.tee 9
    i32.load
    local.get 8
    i32.sub
    i32.const 0
    i32.const 0
    local.get 4
    i32.load offset=24
    local.tee 8
    local.get 4
    i32.load offset=28
    local.get 8
    i32.sub
    call 0
    i32.const 0
    i32.gt_s
    i32.const 8333
    call 5
    local.get 4
    local.get 1
    i64.store offset=8
    local.get 4
    local.get 2
    i64.store
    local.get 4
    local.get 3
    local.get 5
    i32.load
    local.tee 5
    local.get 9
    i32.load
    local.get 5
    i32.sub
    i32.const 0
    call 14
    local.get 4
    i32.const 120
    i32.add
    local.get 6
    call 42
    local.get 4
    i32.const 80
    i32.add
    local.get 0
    call 43
    block  ;; label = @1
      local.get 4
      i32.load offset=24
      local.tee 5
      i32.eqz
      br_if 0 (;@1;)
      local.get 4
      local.get 5
      i32.store offset=28
      local.get 5
      call 57
    end
    block  ;; label = @1
      local.get 4
      i32.load offset=104
      local.tee 8
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          i32.const 108
          i32.add
          local.tee 9
          i32.load
          local.tee 6
          local.get 8
          i32.eq
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 6
            i32.const -24
            i32.add
            local.tee 6
            i32.load
            local.set 5
            local.get 6
            i32.const 0
            i32.store
            block  ;; label = @5
              local.get 5
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 5
                i32.load offset=20
                local.tee 0
                i32.eqz
                br_if 0 (;@6;)
                local.get 5
                i32.const 24
                i32.add
                local.get 0
                i32.store
                local.get 0
                call 57
              end
              block  ;; label = @6
                local.get 5
                i32.load offset=8
                local.tee 0
                i32.eqz
                br_if 0 (;@6;)
                local.get 5
                i32.const 12
                i32.add
                local.get 0
                i32.store
                local.get 0
                call 57
              end
              local.get 5
              call 57
            end
            local.get 8
            local.get 6
            i32.ne
            br_if 0 (;@4;)
          end
          local.get 4
          i32.const 104
          i32.add
          i32.load
          local.set 5
          br 1 (;@2;)
        end
        local.get 8
        local.set 5
      end
      local.get 9
      local.get 8
      i32.store
      local.get 5
      call 57
    end
    block  ;; label = @1
      local.get 4
      i32.load offset=144
      local.tee 8
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          i32.const 148
          i32.add
          local.tee 9
          i32.load
          local.tee 5
          local.get 8
          i32.eq
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 5
            i32.const -24
            i32.add
            local.tee 5
            i32.load
            local.set 6
            local.get 5
            i32.const 0
            i32.store
            block  ;; label = @5
              local.get 6
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 6
                i32.load offset=8
                local.tee 0
                i32.eqz
                br_if 0 (;@6;)
                local.get 6
                i32.const 12
                i32.add
                local.get 0
                i32.store
                local.get 0
                call 57
              end
              local.get 6
              call 57
            end
            local.get 8
            local.get 5
            i32.ne
            br_if 0 (;@4;)
          end
          local.get 4
          i32.const 144
          i32.add
          i32.load
          local.set 5
          br 1 (;@2;)
        end
        local.get 8
        local.set 5
      end
      local.get 9
      local.get 8
      i32.store
      local.get 5
      call 57
    end
    local.get 4
    i32.const 160
    i32.add
    global.set 0)
  (func (;45;) (type 20) (param i64 i64 i64)
    (local i32 i64)
    global.get 0
    i32.const 96
    i32.sub
    local.tee 3
    global.set 0
    call 21
    i64.const 7
    local.set 4
    loop  ;; label = @1
      local.get 4
      i64.const 1
      i64.add
      local.tee 4
      i64.const 13
      i64.ne
      br_if 0 (;@1;)
    end
    block  ;; label = @1
      i64.const -6569208335818555392
      local.get 2
      i64.ne
      br_if 0 (;@1;)
      i64.const 5
      local.set 4
      loop  ;; label = @2
        local.get 4
        i64.const 1
        i64.add
        local.tee 4
        i64.const 13
        i64.ne
        br_if 0 (;@2;)
      end
      i64.const 6138663577826885632
      local.get 1
      i64.eq
      i32.const 8498
      call 5
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 0
        i64.eq
        br_if 0 (;@2;)
        i64.const 7
        local.set 4
        loop  ;; label = @3
          local.get 4
          i64.const 1
          i64.add
          local.tee 4
          i64.const 13
          i64.ne
          br_if 0 (;@3;)
        end
        i64.const -6569208335818555392
        local.get 2
        i64.ne
        br_if 1 (;@1;)
      end
      local.get 3
      local.get 0
      i64.store offset=88
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i64.const 3849304916161986559
              i64.le_s
              br_if 0 (;@5;)
              local.get 2
              i64.const 3849304916161986560
              i64.eq
              br_if 1 (;@4;)
              local.get 2
              i64.const 4730614985703555072
              i64.eq
              br_if 2 (;@3;)
              local.get 2
              i64.const 6292795316831780864
              i64.ne
              br_if 4 (;@1;)
              local.get 3
              i32.const 0
              i32.store offset=52
              local.get 3
              i32.const 1
              i32.store offset=48
              local.get 3
              local.get 3
              i64.load offset=48
              i64.store offset=40
              local.get 3
              i32.const 88
              i32.add
              local.get 3
              i32.const 40
              i32.add
              call 46
              drop
              br 4 (;@1;)
            end
            local.get 2
            i64.const -5915097261842366464
            i64.eq
            br_if 2 (;@2;)
            local.get 2
            i64.const -3112731855308193792
            i64.ne
            br_if 3 (;@1;)
            local.get 3
            i32.const 0
            i32.store offset=68
            local.get 3
            i32.const 2
            i32.store offset=64
            local.get 3
            local.get 3
            i64.load offset=64
            i64.store offset=24
            local.get 3
            i32.const 88
            i32.add
            local.get 3
            i32.const 24
            i32.add
            call 47
            drop
            br 3 (;@1;)
          end
          local.get 3
          i32.const 0
          i32.store offset=76
          local.get 3
          i32.const 3
          i32.store offset=72
          local.get 3
          local.get 3
          i64.load offset=72
          i64.store offset=16
          local.get 3
          i32.const 88
          i32.add
          local.get 3
          i32.const 16
          i32.add
          call 47
          drop
          br 2 (;@1;)
        end
        local.get 3
        i32.const 0
        i32.store offset=60
        local.get 3
        i32.const 4
        i32.store offset=56
        local.get 3
        local.get 3
        i64.load offset=56
        i64.store offset=32
        local.get 3
        i32.const 88
        i32.add
        local.get 3
        i32.const 32
        i32.add
        call 46
        drop
        br 1 (;@1;)
      end
      local.get 3
      i32.const 0
      i32.store offset=84
      local.get 3
      i32.const 5
      i32.store offset=80
      local.get 3
      local.get 3
      i64.load offset=80
      i64.store offset=8
      local.get 3
      i32.const 88
      i32.add
      local.get 3
      i32.const 8
      i32.add
      call 48
      drop
    end
    i32.const 0
    call 60
    local.get 3
    i32.const 96
    i32.add
    global.set 0)
  (func (;46;) (type 7) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i64 i64 i64)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 2
    local.set 3
    local.get 2
    global.set 0
    local.get 1
    i32.load offset=4
    local.set 4
    local.get 1
    i32.load
    local.set 5
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            call 2
            local.tee 1
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            i32.const 513
            i32.lt_u
            br_if 1 (;@3;)
            local.get 1
            call 51
            local.set 2
            br 2 (;@2;)
          end
          i32.const 0
          local.set 2
          br 2 (;@1;)
        end
        local.get 2
        local.get 1
        i32.const 15
        i32.add
        i32.const -16
        i32.and
        i32.sub
        local.tee 2
        global.set 0
      end
      local.get 2
      local.get 1
      call 3
      drop
    end
    local.get 3
    i64.const 0
    i64.store offset=16
    local.get 3
    i64.const 0
    i64.store offset=8
    local.get 3
    i64.const 0
    i64.store offset=24
    local.get 1
    i32.const 7
    i32.gt_u
    i32.const 8568
    call 5
    local.get 3
    i32.const 8
    i32.add
    local.get 2
    i32.const 8
    call 6
    drop
    local.get 1
    i32.const -8
    i32.and
    local.tee 6
    i32.const 8
    i32.ne
    i32.const 8568
    call 5
    local.get 3
    i32.const 8
    i32.add
    i32.const 8
    i32.add
    local.tee 7
    local.get 2
    i32.const 8
    i32.add
    i32.const 8
    call 6
    drop
    local.get 6
    i32.const 16
    i32.ne
    i32.const 8568
    call 5
    local.get 3
    i32.const 8
    i32.add
    i32.const 16
    i32.add
    local.tee 6
    local.get 2
    i32.const 16
    i32.add
    i32.const 8
    call 6
    drop
    block  ;; label = @1
      local.get 1
      i32.const 513
      i32.lt_u
      br_if 0 (;@1;)
      local.get 2
      call 54
    end
    local.get 0
    local.get 4
    i32.const 1
    i32.shr_s
    i32.add
    local.set 1
    local.get 6
    i64.load
    local.set 8
    local.get 7
    i64.load
    local.set 9
    local.get 3
    i64.load offset=8
    local.set 10
    block  ;; label = @1
      local.get 4
      i32.const 1
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.load
      local.get 5
      i32.add
      i32.load
      local.set 5
    end
    local.get 1
    local.get 10
    local.get 9
    local.get 8
    local.get 5
    call_indirect (type 0)
    local.get 3
    i32.const 32
    i32.add
    global.set 0
    i32.const 1)
  (func (;47;) (type 7) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i64 i64 i64)
    global.get 0
    i32.const 96
    i32.sub
    local.tee 2
    local.set 3
    local.get 2
    global.set 0
    local.get 1
    i32.load offset=4
    local.set 4
    local.get 1
    i32.load
    local.set 5
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            call 2
            local.tee 6
            i32.eqz
            br_if 0 (;@4;)
            local.get 6
            i32.const 513
            i32.lt_u
            br_if 1 (;@3;)
            local.get 6
            call 51
            local.set 1
            br 2 (;@2;)
          end
          i32.const 0
          local.set 1
          br 2 (;@1;)
        end
        local.get 2
        local.get 6
        i32.const 15
        i32.add
        i32.const -16
        i32.and
        i32.sub
        local.tee 1
        global.set 0
      end
      local.get 1
      local.get 6
      call 3
      drop
    end
    local.get 3
    i64.const 0
    i64.store offset=24
    local.get 3
    i64.const 0
    i64.store offset=16
    local.get 3
    local.get 1
    i32.store offset=84
    local.get 3
    local.get 1
    i32.store offset=80
    local.get 3
    local.get 1
    local.get 6
    i32.add
    i32.store offset=88
    local.get 3
    local.get 3
    i32.const 80
    i32.add
    i32.store offset=48
    local.get 3
    local.get 3
    i32.const 16
    i32.add
    i32.store offset=64
    local.get 3
    i32.const 64
    i32.add
    local.get 3
    i32.const 48
    i32.add
    call 49
    block  ;; label = @1
      local.get 6
      i32.const 513
      i32.lt_u
      br_if 0 (;@1;)
      local.get 1
      call 54
    end
    local.get 3
    i32.const 48
    i32.add
    i32.const 8
    i32.add
    local.tee 1
    local.get 3
    i32.const 40
    i32.add
    i64.load
    i64.store
    local.get 3
    local.get 3
    i64.load offset=32
    i64.store offset=48
    local.get 3
    i32.const 16
    i32.add
    i32.const 8
    i32.add
    i64.load
    local.set 7
    local.get 3
    i64.load offset=16
    local.set 8
    local.get 3
    i32.const 64
    i32.add
    i32.const 8
    i32.add
    local.get 1
    i64.load
    i64.store
    local.get 3
    local.get 3
    i64.load offset=48
    i64.store offset=64
    local.get 0
    local.get 4
    i32.const 1
    i32.shr_s
    i32.add
    local.set 1
    block  ;; label = @1
      local.get 4
      i32.const 1
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.load
      local.get 5
      i32.add
      i32.load
      local.set 5
    end
    local.get 3
    i32.const 80
    i32.add
    i32.const 8
    i32.add
    local.get 3
    i32.const 64
    i32.add
    i32.const 8
    i32.add
    i64.load
    local.tee 9
    i64.store
    local.get 3
    i32.const 8
    i32.add
    local.get 9
    i64.store
    local.get 3
    local.get 3
    i64.load offset=64
    local.tee 9
    i64.store
    local.get 3
    local.get 9
    i64.store offset=80
    local.get 1
    local.get 8
    local.get 7
    local.get 3
    local.get 5
    call_indirect (type 1)
    local.get 3
    i32.const 96
    i32.add
    global.set 0
    i32.const 1)
  (func (;48;) (type 7) (param i32 i32) (result i32)
    (local i32 i32 i32 i32)
    global.get 0
    local.tee 2
    local.set 3
    local.get 1
    i32.load offset=4
    local.set 4
    local.get 1
    i32.load
    local.set 1
    block  ;; label = @1
      call 2
      local.tee 5
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 5
        i32.const 512
        i32.le_u
        br_if 0 (;@2;)
        local.get 5
        call 51
        local.tee 2
        local.get 5
        call 3
        drop
        local.get 2
        call 54
        br 1 (;@1;)
      end
      local.get 2
      local.get 5
      i32.const 15
      i32.add
      i32.const -16
      i32.and
      i32.sub
      local.tee 2
      global.set 0
      local.get 2
      local.get 5
      call 3
      drop
    end
    local.get 0
    local.get 4
    i32.const 1
    i32.shr_s
    i32.add
    local.set 5
    block  ;; label = @1
      local.get 4
      i32.const 1
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 5
      i32.load
      local.get 1
      i32.add
      i32.load
      local.set 1
    end
    local.get 5
    local.get 1
    call_indirect (type 2)
    local.get 3
    global.set 0
    i32.const 1)
  (func (;49;) (type 9) (param i32 i32)
    (local i32 i32)
    local.get 0
    i32.load
    local.set 2
    local.get 1
    i32.load
    local.tee 3
    i32.load offset=8
    local.get 3
    i32.load offset=4
    i32.sub
    i32.const 7
    i32.gt_u
    i32.const 8568
    call 5
    local.get 2
    local.get 3
    i32.load offset=4
    i32.const 8
    call 6
    drop
    local.get 3
    local.get 3
    i32.load offset=4
    i32.const 8
    i32.add
    i32.store offset=4
    local.get 0
    i32.load
    local.set 0
    local.get 1
    i32.load
    local.tee 3
    i32.load offset=8
    local.get 3
    i32.load offset=4
    i32.sub
    i32.const 7
    i32.gt_u
    i32.const 8568
    call 5
    local.get 0
    i32.const 8
    i32.add
    local.get 3
    i32.load offset=4
    i32.const 8
    call 6
    drop
    local.get 3
    local.get 3
    i32.load offset=4
    i32.const 8
    i32.add
    i32.store offset=4
    local.get 1
    i32.load
    local.tee 3
    i32.load offset=8
    local.get 3
    i32.load offset=4
    i32.sub
    i32.const 7
    i32.gt_u
    i32.const 8568
    call 5
    local.get 0
    i32.const 16
    i32.add
    local.get 3
    i32.load offset=4
    i32.const 8
    call 6
    drop
    local.get 3
    local.get 3
    i32.load offset=4
    i32.const 8
    i32.add
    local.tee 1
    i32.store offset=4
    local.get 3
    i32.load offset=8
    local.get 1
    i32.sub
    i32.const 7
    i32.gt_u
    i32.const 8568
    call 5
    local.get 0
    i32.const 24
    i32.add
    local.get 3
    i32.load offset=4
    i32.const 8
    call 6
    drop
    local.get 3
    local.get 3
    i32.load offset=4
    i32.const 8
    i32.add
    i32.store offset=4)
  (func (;50;) (type 7) (param i32 i32) (result i32)
    (local i32 i32 i64 i32 i32 i32)
    local.get 0
    i32.load offset=4
    local.set 2
    i32.const 0
    local.set 3
    i64.const 0
    local.set 4
    local.get 0
    i32.const 8
    i32.add
    local.set 5
    local.get 0
    i32.const 4
    i32.add
    local.set 6
    loop  ;; label = @1
      local.get 2
      local.get 5
      i32.load
      i32.lt_u
      i32.const 8573
      call 5
      local.get 6
      i32.load
      local.tee 2
      i32.load8_u
      local.set 7
      local.get 6
      local.get 2
      i32.const 1
      i32.add
      local.tee 2
      i32.store
      local.get 4
      local.get 7
      i32.const 127
      i32.and
      local.get 3
      i32.const 255
      i32.and
      local.tee 3
      i32.shl
      i64.extend_i32_u
      i64.or
      local.set 4
      local.get 3
      i32.const 7
      i32.add
      local.set 3
      local.get 7
      i32.const 128
      i32.and
      br_if 0 (;@1;)
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.load offset=4
        local.tee 3
        local.get 1
        i32.load
        local.tee 7
        i32.sub
        local.tee 5
        local.get 4
        i32.wrap_i64
        local.tee 6
        i32.ge_u
        br_if 0 (;@2;)
        local.get 1
        local.get 6
        local.get 5
        i32.sub
        call 22
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.set 2
        local.get 1
        i32.const 4
        i32.add
        i32.load
        local.set 3
        local.get 1
        i32.load
        local.set 7
        br 1 (;@1;)
      end
      local.get 5
      local.get 6
      i32.le_u
      br_if 0 (;@1;)
      local.get 1
      i32.const 4
      i32.add
      local.get 7
      local.get 6
      i32.add
      local.tee 3
      i32.store
    end
    local.get 0
    i32.const 8
    i32.add
    i32.load
    local.get 2
    i32.sub
    local.get 3
    local.get 7
    i32.sub
    local.tee 2
    i32.ge_u
    i32.const 8568
    call 5
    local.get 7
    local.get 0
    i32.const 4
    i32.add
    local.tee 3
    i32.load
    local.get 2
    call 6
    drop
    local.get 3
    local.get 3
    i32.load
    local.get 2
    i32.add
    i32.store
    local.get 0)
  (func (;51;) (type 21) (param i32) (result i32)
    i32.const 9016
    local.get 0
    call 52)
  (func (;52;) (type 7) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 0
        i32.load offset=8384
        local.tee 2
        br_if 0 (;@2;)
        i32.const 16
        local.set 2
        local.get 0
        i32.const 8384
        i32.add
        i32.const 16
        i32.store
      end
      local.get 1
      i32.const 8
      i32.add
      local.get 1
      i32.const 4
      i32.add
      i32.const 7
      i32.and
      local.tee 3
      i32.sub
      local.get 1
      local.get 3
      select
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load offset=8388
            local.tee 4
            local.get 2
            i32.ge_u
            br_if 0 (;@4;)
            local.get 0
            local.get 4
            i32.const 12
            i32.mul
            i32.add
            i32.const 8192
            i32.add
            local.set 1
            block  ;; label = @5
              local.get 4
              br_if 0 (;@5;)
              local.get 0
              i32.const 8196
              i32.add
              local.tee 2
              i32.load
              br_if 0 (;@5;)
              local.get 1
              i32.const 8192
              i32.store
              local.get 2
              local.get 0
              i32.store
            end
            local.get 3
            i32.const 4
            i32.add
            local.set 4
            loop  ;; label = @5
              block  ;; label = @6
                local.get 1
                i32.load offset=8
                local.tee 2
                local.get 4
                i32.add
                local.get 1
                i32.load
                i32.gt_u
                br_if 0 (;@6;)
                local.get 1
                i32.load offset=4
                local.get 2
                i32.add
                local.tee 2
                local.get 2
                i32.load
                i32.const -2147483648
                i32.and
                local.get 3
                i32.or
                i32.store
                local.get 1
                i32.const 8
                i32.add
                local.tee 1
                local.get 1
                i32.load
                local.get 4
                i32.add
                i32.store
                local.get 2
                local.get 2
                i32.load
                i32.const -2147483648
                i32.or
                i32.store
                local.get 2
                i32.const 4
                i32.add
                local.tee 1
                br_if 3 (;@3;)
              end
              local.get 0
              call 53
              local.tee 1
              br_if 0 (;@5;)
            end
          end
          i32.const 2147483644
          local.get 3
          i32.sub
          local.set 5
          local.get 0
          i32.const 8392
          i32.add
          local.set 6
          local.get 0
          i32.const 8384
          i32.add
          local.set 7
          local.get 0
          i32.load offset=8392
          local.tee 8
          local.set 2
          loop  ;; label = @4
            local.get 0
            local.get 2
            i32.const 12
            i32.mul
            i32.add
            local.tee 1
            i32.const 8200
            i32.add
            i32.load
            local.get 1
            i32.const 8192
            i32.add
            local.tee 9
            i32.load
            i32.eq
            i32.const 8247
            call 5
            local.get 1
            i32.const 8196
            i32.add
            i32.load
            local.tee 10
            i32.const 4
            i32.add
            local.set 2
            loop  ;; label = @5
              local.get 10
              local.get 9
              i32.load
              i32.add
              local.set 11
              local.get 2
              i32.const -4
              i32.add
              local.tee 12
              i32.load
              local.tee 13
              i32.const 2147483647
              i32.and
              local.set 1
              block  ;; label = @6
                local.get 13
                i32.const 0
                i32.lt_s
                br_if 0 (;@6;)
                block  ;; label = @7
                  local.get 1
                  local.get 3
                  i32.ge_u
                  br_if 0 (;@7;)
                  loop  ;; label = @8
                    local.get 2
                    local.get 1
                    i32.add
                    local.tee 4
                    local.get 11
                    i32.ge_u
                    br_if 1 (;@7;)
                    local.get 4
                    i32.load
                    local.tee 4
                    i32.const 0
                    i32.lt_s
                    br_if 1 (;@7;)
                    local.get 1
                    local.get 4
                    i32.const 2147483647
                    i32.and
                    i32.add
                    i32.const 4
                    i32.add
                    local.tee 1
                    local.get 3
                    i32.lt_u
                    br_if 0 (;@8;)
                  end
                end
                local.get 12
                local.get 1
                local.get 3
                local.get 1
                local.get 3
                i32.lt_u
                select
                local.get 13
                i32.const -2147483648
                i32.and
                i32.or
                i32.store
                block  ;; label = @7
                  local.get 1
                  local.get 3
                  i32.le_u
                  br_if 0 (;@7;)
                  local.get 2
                  local.get 3
                  i32.add
                  local.get 5
                  local.get 1
                  i32.add
                  i32.const 2147483647
                  i32.and
                  i32.store
                end
                local.get 1
                local.get 3
                i32.ge_u
                br_if 4 (;@2;)
              end
              local.get 2
              local.get 1
              i32.add
              i32.const 4
              i32.add
              local.tee 2
              local.get 11
              i32.lt_u
              br_if 0 (;@5;)
            end
            i32.const 0
            local.set 1
            local.get 6
            i32.const 0
            local.get 6
            i32.load
            i32.const 1
            i32.add
            local.tee 2
            local.get 2
            local.get 7
            i32.load
            i32.eq
            select
            local.tee 2
            i32.store
            local.get 2
            local.get 8
            i32.ne
            br_if 0 (;@4;)
          end
        end
        local.get 1
        return
      end
      local.get 12
      local.get 12
      i32.load
      i32.const -2147483648
      i32.or
      i32.store
      local.get 2
      return
    end
    i32.const 0)
  (func (;53;) (type 21) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    local.get 0
    i32.load offset=8388
    local.set 1
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.load8_u offset=9008
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        i32.load offset=9012
        local.set 2
        br 1 (;@1;)
      end
      memory.size
      local.set 2
      i32.const 0
      i32.const 1
      i32.store8 offset=9008
      i32.const 0
      local.get 2
      i32.const 16
      i32.shl
      local.tee 2
      i32.store offset=9012
    end
    local.get 2
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.const 65535
            i32.add
            i32.const 16
            i32.shr_u
            local.tee 4
            memory.size
            local.tee 5
            i32.le_u
            br_if 0 (;@4;)
            local.get 4
            local.get 5
            i32.sub
            memory.grow
            drop
            i32.const 0
            local.set 5
            local.get 4
            memory.size
            i32.ne
            br_if 1 (;@3;)
            i32.const 0
            i32.load offset=9012
            local.set 3
          end
          i32.const 0
          local.set 5
          i32.const 0
          local.get 3
          i32.store offset=9012
          local.get 2
          i32.const 0
          i32.lt_s
          br_if 0 (;@3;)
          local.get 1
          i32.const 12
          i32.mul
          local.set 4
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i32.const 65535
              i32.and
              local.tee 5
              i32.const 64512
              i32.gt_u
              br_if 0 (;@5;)
              local.get 2
              i32.const 65536
              i32.add
              local.get 5
              i32.sub
              local.set 5
              br 1 (;@4;)
            end
            local.get 2
            i32.const 131072
            i32.add
            local.get 2
            i32.const 131071
            i32.and
            i32.sub
            local.set 5
          end
          local.get 0
          local.get 4
          i32.add
          local.set 4
          local.get 5
          local.get 2
          i32.sub
          local.set 2
          block  ;; label = @4
            i32.const 0
            i32.load8_u offset=9008
            br_if 0 (;@4;)
            memory.size
            local.set 3
            i32.const 0
            i32.const 1
            i32.store8 offset=9008
            i32.const 0
            local.get 3
            i32.const 16
            i32.shl
            local.tee 3
            i32.store offset=9012
          end
          local.get 4
          i32.const 8192
          i32.add
          local.set 4
          local.get 2
          i32.const 0
          i32.lt_s
          br_if 1 (;@2;)
          local.get 3
          local.set 6
          block  ;; label = @4
            local.get 2
            i32.const 7
            i32.add
            i32.const -8
            i32.and
            local.tee 7
            local.get 3
            i32.add
            i32.const 65535
            i32.add
            i32.const 16
            i32.shr_u
            local.tee 5
            memory.size
            local.tee 8
            i32.le_u
            br_if 0 (;@4;)
            local.get 5
            local.get 8
            i32.sub
            memory.grow
            drop
            local.get 5
            memory.size
            i32.ne
            br_if 2 (;@2;)
            i32.const 0
            i32.load offset=9012
            local.set 6
          end
          i32.const 0
          local.get 6
          local.get 7
          i32.add
          i32.store offset=9012
          local.get 3
          i32.const -1
          i32.eq
          br_if 1 (;@2;)
          local.get 0
          local.get 1
          i32.const 12
          i32.mul
          i32.add
          local.tee 1
          i32.const 8196
          i32.add
          i32.load
          local.tee 6
          local.get 4
          i32.load
          local.tee 5
          i32.add
          local.get 3
          i32.eq
          br_if 2 (;@1;)
          block  ;; label = @4
            local.get 5
            local.get 1
            i32.const 8200
            i32.add
            local.tee 7
            i32.load
            local.tee 1
            i32.eq
            br_if 0 (;@4;)
            local.get 6
            local.get 1
            i32.add
            local.tee 6
            local.get 6
            i32.load
            i32.const -2147483648
            i32.and
            i32.const -4
            local.get 1
            i32.sub
            local.get 5
            i32.add
            i32.or
            i32.store
            local.get 7
            local.get 4
            i32.load
            i32.store
            local.get 6
            local.get 6
            i32.load
            i32.const 2147483647
            i32.and
            i32.store
          end
          local.get 0
          i32.const 8388
          i32.add
          local.tee 4
          local.get 4
          i32.load
          i32.const 1
          i32.add
          local.tee 4
          i32.store
          local.get 0
          local.get 4
          i32.const 12
          i32.mul
          i32.add
          local.tee 0
          i32.const 8192
          i32.add
          local.tee 5
          local.get 2
          i32.store
          local.get 0
          i32.const 8196
          i32.add
          local.get 3
          i32.store
        end
        local.get 5
        return
      end
      block  ;; label = @2
        local.get 4
        i32.load
        local.tee 5
        local.get 0
        local.get 1
        i32.const 12
        i32.mul
        i32.add
        local.tee 3
        i32.const 8200
        i32.add
        local.tee 1
        i32.load
        local.tee 2
        i32.eq
        br_if 0 (;@2;)
        local.get 3
        i32.const 8196
        i32.add
        i32.load
        local.get 2
        i32.add
        local.tee 3
        local.get 3
        i32.load
        i32.const -2147483648
        i32.and
        i32.const -4
        local.get 2
        i32.sub
        local.get 5
        i32.add
        i32.or
        i32.store
        local.get 1
        local.get 4
        i32.load
        i32.store
        local.get 3
        local.get 3
        i32.load
        i32.const 2147483647
        i32.and
        i32.store
      end
      local.get 0
      local.get 0
      i32.const 8388
      i32.add
      local.tee 2
      i32.load
      i32.const 1
      i32.add
      local.tee 3
      i32.store offset=8384
      local.get 2
      local.get 3
      i32.store
      i32.const 0
      return
    end
    local.get 4
    local.get 5
    local.get 2
    i32.add
    i32.store
    local.get 4)
  (func (;54;) (type 2) (param i32)
    (local i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        i32.load offset=17400
        local.tee 1
        i32.const 1
        i32.lt_s
        br_if 0 (;@2;)
        i32.const 17208
        local.set 2
        local.get 1
        i32.const 12
        i32.mul
        i32.const 17208
        i32.add
        local.set 3
        loop  ;; label = @3
          local.get 2
          i32.const 4
          i32.add
          i32.load
          local.tee 1
          i32.eqz
          br_if 1 (;@2;)
          block  ;; label = @4
            local.get 1
            i32.const 4
            i32.add
            local.get 0
            i32.gt_u
            br_if 0 (;@4;)
            local.get 1
            local.get 2
            i32.load
            i32.add
            local.get 0
            i32.gt_u
            br_if 3 (;@1;)
          end
          local.get 2
          i32.const 12
          i32.add
          local.tee 2
          local.get 3
          i32.lt_u
          br_if 0 (;@3;)
        end
      end
      return
    end
    local.get 0
    i32.const -4
    i32.add
    local.tee 2
    local.get 2
    i32.load
    i32.const 2147483647
    i32.and
    i32.store)
  (func (;55;) (type 21) (param i32) (result i32)
    (local i32 i32)
    block  ;; label = @1
      local.get 0
      i32.const 1
      local.get 0
      select
      local.tee 1
      call 51
      local.tee 0
      br_if 0 (;@1;)
      loop  ;; label = @2
        i32.const 0
        local.set 0
        i32.const 0
        i32.load offset=17412
        local.tee 2
        i32.eqz
        br_if 1 (;@1;)
        local.get 2
        call_indirect (type 3)
        local.get 1
        call 51
        local.tee 0
        i32.eqz
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (func (;56;) (type 21) (param i32) (result i32)
    local.get 0
    call 55)
  (func (;57;) (type 2) (param i32)
    block  ;; label = @1
      local.get 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      call 54
    end)
  (func (;58;) (type 2) (param i32)
    local.get 0
    call 57)
  (func (;59;) (type 2) (param i32)
    call 15
    unreachable)
  (func (;60;) (type 2) (param i32))
  (table (;0;) 6 6 funcref)
  (memory (;0;) 1)
  (global (;0;) (mut i32) (i32.const 8192))
  (global (;1;) i32 (i32.const 17416))
  (global (;2;) i32 (i32.const 17416))
  (export "memory" (memory 0))
  (export "__heap_base" (global 1))
  (export "__data_end" (global 2))
  (export "apply" (func 45))
  (export "_ZdlPv" (func 57))
  (export "_Znwj" (func 55))
  (export "_Znaj" (func 56))
  (export "_ZdaPv" (func 58))
  (elem (;0;) (i32.const 1) func 44 38 33 40 23)
  (data (;0;) (i32.const 8192) "transaction expired\00")
  (data (;1;) (i32.const 8212) "proposal with the same name exists\00malloc_from_freed was designed to only be called after _heap was completely allocated\00")
  (data (;2;) (i32.const 8333) "transaction authorization failed\00")
  (data (;3;) (i32.const 8366) "proposal not found\00")
  (data (;4;) (i32.const 8385) "approval is not on the list of requested approvals\00")
  (data (;5;) (i32.const 8436) "no approval previously granted\00")
  (data (;6;) (i32.const 8467) "cannot cancel until expiration\00")
  (data (;7;) (i32.const 8498) "onerror action's are only valid from the \22sysio\22 system account\00")
  (data (;8;) (i32.const 8562) "write\00")
  (data (;9;) (i32.const 8568) "read\00")
  (data (;10;) (i32.const 8573) "get\00")
  (data (;11;) (i32.const 8577) "object passed to iterator_to is not in multi_index\00")
  (data (;12;) (i32.const 8628) "error reading iterator\00")
  (data (;13;) (i32.const 8651) "cannot create objects in table of another contract\00")
  (data (;14;) (i32.const 8702) "object passed to modify is not in multi_index\00")
  (data (;15;) (i32.const 8748) "cannot modify objects in table of another contract\00")
  (data (;16;) (i32.const 8799) "updater cannot change primary key when modifying an object\00")
  (data (;17;) (i32.const 8858) "object passed to erase is not in multi_index\00")
  (data (;18;) (i32.const 8903) "cannot erase objects in table of another contract\00")
  (data (;19;) (i32.const 8953) "attempt to remove object that was not in multi_index\00"))
