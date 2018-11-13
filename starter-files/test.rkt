#lang racket

(require lang-file/read-lang-file)
(require syntax/parse)


(define s (read-lang-file "tsgd_runner_1.rkt"))


(syntax-parse s #:literals (define )
  [(module ...
     (define WIDTH body:expr)
     ...
     )
   #'(body ...)]
  [else 'no])


