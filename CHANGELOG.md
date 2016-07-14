# CHANGELOG

## 1.0.0

 * support Rails `5.0`
 * cancel support for Ruby < `2.2`

## 0.5.0

 * fix issue with encoding for latest _mail_ gem version (`2.6.4`)
 * drop support for Ruby version 1.8.7 and 1.9.2
 * re-use assert_json code from the assert_json gem

## 0.4.0

 * supporting `refute_mail` now as well (minitest style) (see [issue #4](https://github.com/alto/seatbelt/pull/4)), thanks to [@jch](https://github.com/jch)

## 0.3.1

 * bugfix for Rails 4.1 and Minitest 5.x support

## 0.3.0

 * added support for Rails 4.1 and Minitest >= 5.x (thanks to [@clod81](https://github.com/clod81))

## 0.2.0

 * added support for Rails 4.0 (thanks to [@clod81](https://github.com/clod81))

## 0.1.2

  * added assert_content_type

## 0.1.1

  * assert_mail subject now support regular explicitly (not implicitly anymore)

## 0.1.0

  * include assert_mail
  * include assert_json
  * initial version
