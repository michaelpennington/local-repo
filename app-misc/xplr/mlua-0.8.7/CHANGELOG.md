## v0.8.7

- Minimum Luau updated to 0.555 (`LUAI_MAXCSTACK` limit increased to 100000)
- `_VERSION` in Luau now includes version number
- Fixed lifetime of `DebugNames` in `Debug::names()` and `DebugSource` in `Debug::source()`
- Fixed subtraction overflow when calculating index for `MultiValue::get()`

## v0.8.6

- Fixed bug when recycled Registry slot can be set to Nil

## v0.8.5

- Fixed potential unsoundness when using `Layout::from_size_align_unchecked` and Rust 1.65+
- Performance optimizations around string and table creation in standalone mode
- Added fast track path to Table `get`/`set`/`len` methods without metatable
- Added new methods `push`/`pop`/`raw_push`/`raw_pop` to Table
- Fix getting caller information from `Lua::load`
- Better checks and tests when trying to modify a Luau readonly table

## v0.8.4

- Minimal Luau updated to 0.548

## v0.8.3

- Close to-be-closed variables for Lua 5.4 when using call_async functions (#192)
- Fixed Lua assertion when inspecting another thread stack. (#195)
- Use more reliable way to create LuaJIT VM (which can fail if use Rust allocator on non-x86 platforms)

## v0.8.2

- Performance optimizations in handling UserData
- Minimal Luau updated to 0.536
- Fixed bug in `Function::bind` when passing empty binds and no arguments (#189)

## v0.8.1

- Added `Lua::create_proxy` for accessing to UserData static fields and functions without instance
- Added `Table::to_pointer()` and `String::to_pointer()` functions
- Bugfixes and improvements (#176 #179)

## v0.8.0
Changes since 0.7.4
- Roblox Luau support
- Removed C glue
- Added async support to `__index` and `__newindex` metamethods
- Added `Function::info()` to get information about functions (#149).
- Added `parking_lot` dependency under feature flag (for `UserData`)
- `Hash` implementation for Lua String
- Added `Value::to_pointer()` function
- Performance improvements

Breaking changes:
- Refactored `AsChunk` trait (added implementation for `Path` and `PathBuf`).

## v0.8.0-beta.5

- Lua sources no longer needed to build modules
- Added `__iter` metamethod for Luau
- Added `Value::to_pointer()` function
- Added `Function::coverage` for Luau to obtain coverage report
- Bugfixes and improvements (#153 #161 #168)

## v0.8.0-beta.4

- Removed `&Lua` from `Lua::set_interrupt` as it's not safe (introduced in v0.8.0-beta.3)
- Enabled `Lua::gc_inc` for Luau
- Luau `debug` module marked as safe (enabled by default)
- Implemented `Hash` for Lua String
- Support mode options in `collectgarbage` for Luau
- Added ability to set global Luau compiler (used for loading all chunks).
- Refactored `AsChunk` trait (breaking changes).
  `AsChunk` now implemented for `Path` and `PathBuf` to load lua files from fs.
- Added `parking_lot` dependency and feature flag (for `UserData`)
- Added `Function::info()` to get information about functions (#149).
- Bugfixes and improvements (#104 #142)

## v0.8.0-beta.3

- Luau vector constructor
- Luau sandboxing support
- Luau interrupts (yieldable)
- More Luau compiler options (mutable globals)
- Other performance improvements

## v0.8.0-beta.2

- Luau vector datatype support
- Luau readonly table attribute
- Other Luau improvements

## v0.8.0-beta.1

- Roblox Luau support
- Refactored ffi module. C glue is no longer required
- Added async support to `__index` and `__newindex` metamethods

## v0.7.4

- Improved `Lua::create_registry_value` to reuse previously expired registry keys.
  No need to call `Lua::expire_registry_values` when creating/dropping registry values.
- Added `Lua::replace_registry_value` to change value of an existing Registry Key
- Async calls optimization

## v0.7.3

- Fixed cross-compilation issue (introduced in 84a174c)

## v0.7.2

- Allow `pkg-config` to omit include paths if they equals to standard (#114).
- Various bugfixes (eg. #121)

## v0.7.1

- Fixed traceback generation for errors (#112)
- `Lua::into_static/from_static` methods have been removed from the docs and are discouraged for use

## v0.7.0

- New "application data" api to store arbitrary objects inside Lua
- New feature flag `luajit52` to build/support LuaJIT with partial compatibility with Lua 5.2
- Added async meta methods for all Lua (except 5.1)
- Added `AnyUserData::take()` to take UserData objects from Lua
- Added `set_nth_user_value`/`get_nth_user_value` to `AnyUserData` for all Lua versions
- Added `set_named_user_value`/`get_named_user_value` to `AnyUserData` for all Lua versions
- Added `Lua::inspect_stack()` to get information about the interpreter runtime stack
- Added `set_warning_function`/`remove_warning_function`/`warning` functions to `Lua` for 5.4
- Added `TableExt::call()` to call tables with `__call` metamethod as functions
- Added `Lua::unload()` to unload modules
- `ToLua` implementation for arrays changed to const generics
- Added thread (coroutine) cache for async execution (disabled by default and works for Lua 5.4/JIT)
- LuaOptions and (De)SerializeOptions marked as const
- Fixed recursive tables serialization when using `serde::Serialize` for Lua Tables
- Improved errors reporting. Now source included to `fmt::Display` implementation for `Error::CallbackError`
- Major performance improvements

## v0.6.6

- Fixed calculating `LUA_REGISTRYINDEX` when cross-compiling for lua51/jit (#82)
- Updated documentation & examples

## v0.6.5

- Fixed bug when polling async futures (#77)
- Refactor Waker handling in async code (+10% performance gain when calling async functions)
- Added `Location::caller()` information to `Lua::load()` if chunk's name is None (Rust 1.46+)
- Added serialization of i128/u128 types (serde)

## v0.6.4

- Performance optimizations
- Fixed table traversal used in recursion detection in deserializer

## v0.6.3

- Disabled catching Rust panics in userdata finalizers on drop. It also has positive performance impact.
- Added `Debug::event()` to the hook's Debug structure
- Simplified interface of `hook::HookTriggers`
- Added finalizer to `ExtraData` in module mode. This helps avoiding memory leak on closing state when Lua unloads modules and frees memory.
- Added `DeserializeOptions` struct to control deserializer behavior (`from_value_with` function).

## v0.6.2

- New functionality: `Lua::load_from_function()` and `Lua::create_c_function()`
- Many optimizations in callbacks/userdata creation and methods execution

## v0.6.1

- Update `chunk!` documentation (stable Rust limitations)
- Fixed Lua sequence table conversion to HashSet/BTreeSet
- `once_cell` dependency lowered to 1.0

## v0.6.0
Changes since 0.5.4
- New `UserDataFields` API
- Full access to `UserData` metatables with support of setting arbitrary fields.
- Implement `UserData` for `Rc<RefCell<T>>`/`Arc<Mutex<T>>`/`Arc<RwLock<T>>` where `T: UserData`.
- Added `SerializeOptions` to to change default Lua serializer behaviour (eg. `nil/null/array` serialization)
- Added `LuaOptions` to customize Lua/Rust behaviour (currently panic handling)
- Added `ToLua`/`FromLua` implementation for `Box<str>` and `Box<[T]>`.
- Added `Thread::reset()` for luajit/lua54 to recycle threads (coroutines) with attaching a new function.
- Added `chunk!` macro support to load chunks of Lua code using the Rust tokenizer and optionally capturing Rust variables.
- Improved errors reporting (`Error`'s `__tostring` method formats full stacktraces). This is useful in a module mode.
- Added `String::to_string_lossy`
- Various bugfixes and improvements

Breaking changes:
- Errors are always `Send + Sync` to be compatible with the anyhow crate.
- Removed `Result` from `LuaSerdeExt::null()` and `LuaSerdeExt::array_metatable()` (never fails)
- Removed `Result` from `Function::dump()` (never fails)
- Removed `AnyUserData::has_metamethod()` (in favour of full access to metatables)

## v0.6.0-beta.3

- Errors are always `Send + Sync` to be compatible with anyhow crate
- Implement `UserData` for `Rc<RefCell>`/`Arc<Mutex>`/`Arc<RwLock>`
- Added `__ipairs` metamethod for Lua 5.2
- Added `String::to_string_lossy`
- Various bugfixes and improvements

## v0.6.0-beta.2

- [**Breaking**] Removed `AnyUserData::has_metamethod()`
- Added `Thread::reset()` for luajit/lua54 to recycle threads.
  It's possible to attach a new function to a thread (coroutine).
- Added `chunk!` macro support to load chunks of Lua code using the Rust tokenizer and optinally capturing Rust variables.
- Improved error reporting (`Error`'s `__tostring` method formats full stacktraces). This is useful in the module mode.

## v0.6.0-beta.1

- New `UserDataFields` API
- Allow to define arbitrary MetaMethods
- `MetaMethods::name()` is public
- Do not trigger longjmp in Rust to prevent unwinding across FFI boundaries. See https://github.com/rust-lang/rust/issues/83541
- Added `SerializeOptions` to to change default Lua serializer behaviour (eg. nil/null/array serialization)
- [**Breaking**] Removed `Result` from `LuaSerdeExt::null()` and `LuaSerdeExt::array_metatable()` (never fails)
- [**Breaking**] Removed `Result` from `Function::dump()` (never fails)
- `ToLua`/`FromLua` implementation for `Box<str>` and `Box<[T]>`
- [**Breaking**] Added `LuaOptions` to customize Lua/Rust behaviour (currently panic handling)
- Various bugfixes and performance improvements

## v0.5.4

- Build script improvements
- Improvements in panic handling (resume panic on value popping)
- Fixed bug serializing 3rd party userdata (causes segfault)
- Make error::Error non exhaustive

## v0.5.3

- Fixed bug when returning nil-prefixed multi values from async function (+ test)
- Performance optimisation for async callbacks (polling)

## v0.5.2

- Some performance optimisations (callbacks)
- `ToLua` implementation for `Cow<str>` and `Cow<CStr>`
- Fixed bug with `Scope` destruction of partially polled futures

## v0.5.1

- Support cross compilation that should work well for vendored builds (including LuaJIT with some restrictions)
- Fix numeric types conversion for 32bit Lua
- Update tokio to 1.0 for async examples

## v0.5.0

- Serde support under `serialize` feature flag.
- Re-export `mlua_derive`.
- impl `ToLua` and `FromLua` for `HashSet` and `BTreeSet`

## v0.4.2

- Added `Function::dump()` to dump lua function to a binary chunk
- Added `ChunkMode` enum to mark chunks as text or binary
- Updated `set_memory_limit` doc

## v0.4.0

- Lua 5.4 support with `MetaMethod::Close`.
- `lua53` feature is disabled by default. Now preferred Lua version have to be chosen explicitly.
- Provide safety guaraness for Lua state, which means that potenially unsafe operations, like loading C modules (using `require` or `package.loadlib`) are disabled. Equalient for the previous `Lua::new()` function is `Lua::unsafe_new()`.
- New `send` feature to require `Send`.
- New `module` feature, that disables linking to Lua Core Libraries. Required for modules.
- Don't allow `'callback` outlive `'lua` in `Lua::create_function()` to fix [the unsoundness](tests/compile/static_callback_args.rs).
- Added `Lua::into_static()` to make `'static` Lua state. This is useful to spawn async Lua threads that requires `'static`.
- New function `Lua::set_memory_limit()` (similar to `rlua`) to enable memory restrictions in Lua VM (requires Lua >= 5.2).
- `Scope`, temporary removed in v0.3, is back with async support.
- Removed deprecated `Table::call()` function.
- Added hooks support (backported from rlua 0.17).
- New `AnyUserData::has_metamethod()` function.
- LuaJIT 2.0.5 (the latest stable) support.
- Various bug fixes and improvements.
