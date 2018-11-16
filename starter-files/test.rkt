#lang racket

(provide transform-code
         extract-from-file
         read-lang-file
         define-syntax-class
         (all-from-out syntax/parse))

(require lang-file/read-lang-file)
(require syntax/parse)
(require pict)
(require pict/code)
(require (for-syntax racket))

(define-syntax (extract-from-file stx)
  (define file-name (second (syntax->datum stx)))
  (define thing (third (syntax->datum stx)))

  (datum->syntax stx
                 `(let ([ s (rest
                             (syntax-e
                              (fourth
                               (syntax-e
                                (read-lang-file ,file-name)))))])

                    
                    (syntax-parse s
                      [(any1 ... ,(string->symbol (~a "thing:" thing)) any2 ...)
                       #'thing]
                      [else #f]))))


(define (transform-code #:do (do identity)
                        #:if (rule (thunk* #f))
                        stx)
  (define parts (syntax-e stx))

  (define recursive-call
    (λ(s)
      (transform-code #:do do #:if rule s)))

  (if (list? parts)
      (datum->syntax stx
                     (map recursive-call parts)
                     stx)
      (datum->syntax stx
                     (if (or (eq? rule parts)
                             (and (procedure? rule)
                                  (rule parts)))
                         (do parts)
                         parts)
                     stx)))



(module+ test
  (require (prefix-in h: 2htdp/image))

  (define-syntax-class player-sprite-def
    (pattern ((~datum define) (~datum player-sprite) expr)))

  (define-syntax-class WIDTH-def
    (pattern ((~datum define) (~datum WIDTH) expr)))

  
  (define ret (extract-from-file (build-path "tsgd_runner_1.rkt")
                                 player-sprite-def))

  (define ret2 (extract-from-file (build-path "tsgd_runner_1.rkt")
                                  WIDTH-def))

  (typeset-code (transform-code ret
                                #:do (compose code-align h:frame) 
                                #:if h:image?)))


