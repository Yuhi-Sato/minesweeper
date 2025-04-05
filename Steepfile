D = Steep::Diagnostic

target :domains do
  signature "sig/domains"
  check "domains"

  # 標準ライブラリforwardableを追加
  library "forwardable"

  configure_code_diagnostics(D::Ruby.strict)      # 厳密な型チェックを有効化
  configure_code_diagnostics do |hash|
    hash[D::Ruby::NoMethod] = :error              # メソッドが見つからない場合をエラーに
    hash[D::Ruby::ArgumentTypeMismatch] = :error  # 引数の型が一致しない場合をエラーに
    hash[D::Ruby::ReturnTypeMismatch] = :error    # 戻り値の型が一致しない場合をエラーに
    hash[D::Ruby::BlockTypeMismatch] = :error     # ブロックの型が一致しない場合をエラーに
    hash[D::Ruby::FallbackAny] = :error           # 型推論が失敗した場合をエラーに
  end
end
