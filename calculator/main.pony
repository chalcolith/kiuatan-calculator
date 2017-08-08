
use "kiuatan"

actor Main
  let _env: Env
  let _grammar: ParseRule[U8,ISize]

  new create(env: Env) =>
    _env = env
    _grammar = Calculator()
    _run_test("123", 123)

  fun _run_test(input: String, expected: ISize) =>
    try
      let state = ParseState[U8,ISize].from_seq(input)?
      let result = state.parse(_grammar, state.start())?
      match result
      | let result': ParseResult[U8,ISize] =>
        match result'.value()
        | let actual: ISize =>
          if actual == expected then
            _env.out.print("ok:   " + input + " => " + expected.string())
          else
            _env.out.print("FAIL: " + input + " => " + actual.string()
              + " expected " + expected.string())
          end
          return
        end
      end
    end
    _env.out.print("FAIL: no result")
