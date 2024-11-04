(module
  (type (;0;) (func (param i32 i32)))
  (type (;1;) (func (param i64) (result i32)))
  (type (;2;) (func (param i32 i32 i32) (result i32)))
  (type (;3;) (func (result i32)))
  (type (;4;) (func (param i32 i32) (result i32)))
  (type (;5;) (func))
  (type (;6;) (func (param i32) (result i32)))
  (type (;7;) (func (param i32)))
  (type (;8;) (func (param i64 i64 i64)))
  (type (;9;) (func (result i64)))
  (import "env" "sysio_assert" (func (;0;) (type 0)))
  (import "env" "is_account" (func (;1;) (type 1)))
  (import "env" "memset" (func (;2;) (type 2)))
  (import "env" "action_data_size" (func (;3;) (type 3)))
  (import "env" "read_action_data" (func (;4;) (type 4)))
  (import "env" "memcpy" (func (;5;) (type 2)))
  (func (;6;) (type 5)
    call 8)
  (func (;7;) (type 6) (param i32) (result i32)
    (local i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.eqz
            br_if 0 (;@4;)
            i32.const 0
            i32.const 0
            i32.load offset=8204
            local.get 0
            i32.const 16
            i32.shr_u
            local.tee 1
            i32.add
            local.tee 2
            i32.store offset=8204
            i32.const 0
            i32.const 0
            i32.load offset=8196
            local.tee 3
            local.get 0
            i32.add
            i32.const 7
            i32.add
            i32.const -8
            i32.and
            local.tee 0
            i32.store offset=8196
            local.get 2
            i32.const 16
            i32.shl
            local.get 0
            i32.le_u
            br_if 1 (;@3;)
            local.get 1
            memory.grow
            i32.const -1
            i32.eq
            br_if 2 (;@2;)
            br 3 (;@1;)
          end
          i32.const 0
          return
        end
        i32.const 0
        local.get 2
        i32.const 1
        i32.add
        i32.store offset=8204
        local.get 1
        i32.const 1
        i32.add
        memory.grow
        i32.const -1
        i32.ne
        br_if 1 (;@1;)
      end
      i32.const 0
      i32.const 8208
      call 0
      local.get 3
      return
    end
    local.get 3)
  (func (;8;) (type 5)
    (local i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 0
    i32.const 0
    i32.store offset=12
    i32.const 0
    local.get 0
    i32.load offset=12
    i32.load
    i32.const 7
    i32.add
    i32.const -8
    i32.and
    local.tee 0
    i32.store offset=8196
    i32.const 0
    local.get 0
    i32.store offset=8192
    i32.const 0
    memory.size
    i32.store offset=8204)
  (func (;9;) (type 7) (param i32))
  (func (;10;) (type 8) (param i64 i64 i64)
    (local i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 3
    global.set 0
    call 6
    block  ;; label = @1
      local.get 0
      local.get 1
      i64.eq
      br_if 0 (;@1;)
      i32.const 0
      i32.const 8233
      call 0
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i64.const 6138663577826885632
        i64.ne
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 2
          i64.const -7297973096368160768
          i64.eq
          br_if 0 (;@3;)
          local.get 2
          i64.const -4417316391904870400
          i64.ne
          br_if 1 (;@2;)
          call 11
          i64.const 6138663577826885632
          i64.ne
          br_if 1 (;@2;)
          i64.const -4999377783415635968
          call 1
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 3
        call 12
        local.get 3
        i64.load offset=8
        i64.const -4999377783415635968
        i64.eq
        br_if 1 (;@1;)
      end
      i32.const 0
      i32.const 8261
      call 0
    end
    i32.const 0
    call 9
    local.get 3
    i32.const 16
    i32.add
    global.set 0)
  (func (;11;) (type 9) (result i64)
    (local i32 i32 i32 i64)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 0
    local.set 1
    local.get 0
    global.set 0
    block  ;; label = @1
      block  ;; label = @2
        call 3
        local.tee 2
        i32.const 513
        i32.lt_u
        br_if 0 (;@2;)
        local.get 2
        call 7
        local.set 0
        br 1 (;@1;)
      end
      local.get 0
      local.get 2
      i32.const 15
      i32.add
      i32.const -16
      i32.and
      i32.sub
      local.tee 0
      global.set 0
    end
    local.get 0
    local.get 2
    call 4
    drop
    local.get 1
    i64.const 0
    i64.store offset=8
    block  ;; label = @1
      local.get 2
      i32.const 7
      i32.gt_u
      br_if 0 (;@1;)
      i32.const 0
      i32.const 8283
      call 0
    end
    local.get 1
    i32.const 8
    i32.add
    local.get 0
    i32.const 8
    call 5
    drop
    local.get 1
    i64.load offset=8
    local.set 3
    local.get 1
    i32.const 16
    i32.add
    global.set 0
    local.get 3)
  (func (;12;) (type 7) (param i32)
    (local i32 i32 i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 1
    local.set 2
    local.get 1
    global.set 0
    block  ;; label = @1
      block  ;; label = @2
        call 3
        local.tee 3
        i32.const 513
        i32.lt_u
        br_if 0 (;@2;)
        local.get 3
        call 7
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
    local.get 1
    local.get 3
    call 4
    drop
    local.get 0
    i64.const 0
    i64.store offset=8
    local.get 0
    i64.const 0
    i64.store
    local.get 2
    i64.const 0
    i64.store offset=8
    local.get 2
    i64.const 0
    i64.store
    block  ;; label = @1
      local.get 3
      i32.const 7
      i32.gt_u
      br_if 0 (;@1;)
      i32.const 0
      i32.const 8283
      call 0
    end
    local.get 2
    i32.const 8
    i32.add
    local.get 1
    i32.const 8
    call 5
    drop
    local.get 1
    i32.const 8
    i32.add
    local.set 1
    block  ;; label = @1
      local.get 3
      i32.const -8
      i32.and
      i32.const 8
      i32.ne
      br_if 0 (;@1;)
      i32.const 0
      i32.const 8283
      call 0
    end
    local.get 2
    local.get 1
    i32.const 8
    call 5
    drop
    local.get 0
    local.get 2
    i64.load offset=8
    i64.store
    local.get 0
    i32.const 8
    i32.add
    local.get 2
    i64.load
    i64.store
    local.get 2
    i32.const 16
    i32.add
    global.set 0)
  (table (;0;) 1 1 funcref)
  (memory (;0;) 1)
  (global (;0;) (mut i32) (i32.const 8192))
  (global (;1;) i32 (i32.const 8288))
  (global (;2;) i32 (i32.const 8288))
  (export "apply" (func 10))
  (data (;0;) (i32.const 8208) "failed to allocate pages\00rejecting all notifications\00")
  (data (;1;) (i32.const 8261) "rejecting all actions\00")
  (data (;2;) (i32.const 8283) "read\00")
  (data (;3;) (i32.const 0) "` \00\00"))
