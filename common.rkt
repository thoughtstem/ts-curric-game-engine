#lang slideshow

(displayln "Common")

(provide load-new-code
         
         open-file-video

         death-by-fireball-code-img)


(provide  draw-sprite
          export-from-piskel
          export-video
          open-file
          open-file-video
          test-game
          import-to-piskel)

(provide shrink
         local-bitmap

         replace-sheet

         PACMAN
         PACMAN-BONUS
         MARIO 
         MARIO-BONUS
         G-MUSH
         G-MUSH-BONUS
         R-MUSH
         R-MUSH-BONUS
         STAR
         STAR-BONUS
         LINK
         LINK-BONUS

         this-curriculum
         images
         starter-files

         add-to-player-entity-components
         add-to-start-game
         change-defined-constant
         find-defined-constant
         item-sprite-definition
         player-sprite-definition
         ground-sprite-definition

         try-smw-and-then

         change-sprite-for-defined-constant

         wrap-image-within)

(require racket/runtime-path)
(require syntax/parse)
(require (prefix-in h: 2htdp/image))

(require pict/code)
(require ts-curric-common)
(require (except-in ts-racket scale-to-fit id))

(require racket/runtime-path)

(define-runtime-path images        "images")
(define-runtime-path starter-files "starter-files")

(define-runtime-path this-curriculum ".")

(define (local-avatar s)
  (avatar (~a (path->string images) "/" s)))

(define (local-bitmap s)
  (bitmap (~a (path->string images) "/" s)))


(define (MARIO)        (circlify "blue" (local-avatar "mario")))
(define (MARIO-BONUS)  (circlify "red" (local-avatar "mario")))
(define (PACMAN)       (circlify "blue" (local-avatar "pacman")))
(define (PACMAN-BONUS) (circlify "red" (local-avatar "pacman")))
(define (G-MUSH)       (circlify "blue" (local-avatar "greenMushroom")))
(define (G-MUSH-BONUS) (circlify "red" (local-avatar "greenMushroom")))
(define (R-MUSH)       (circlify "blue" (local-avatar "redMushroom")))
(define (R-MUSH-BONUS) (circlify "red" (local-avatar "redMushroom")))
(define (STAR)         (circlify "blue" (local-avatar "star")))
(define (STAR-BONUS)   (circlify "red" (local-avatar "star")))
(define (LINK)         (circlify "blue" (local-avatar "link")))
(define (LINK-BONUS)   (circlify "red" (local-avatar "link")))
(define (SAMUS)        (circlify "blue" (local-avatar "samus")))
(define (SAMUS-BONUS)  (circlify "red" (local-avatar "samus")))
(define (PIKACHU)          (circlify "blue" (local-avatar "pikachu")))
(define (PIKACHU-BONUS)    (circlify "red" (local-avatar "pikachu")))
(define (CHARMANDER)       (circlify "blue" (local-avatar "charmander")))
(define (CHARMANDER-BONUS) (circlify "red" (local-avatar "charmander")))
(define (SQUIRTLE)         (circlify "blue" (local-avatar "squirtle")))
(define (SQUIRTLE-BONUS)   (circlify "red" (local-avatar "squirtle")))
(define (YOSHI)         (circlify "blue" (local-avatar "yoshi")))
(define (YOSHI-BONUS)   (circlify "red" (local-avatar "yoshi")))
(define (SONIC)         (circlify "blue" (local-avatar "sonic")))
(define (SONIC-BONUS)   (circlify "red" (local-avatar "sonic")))

(define (shrink i)
  (quest-card-material
   i))


(define-webpage open-file-video
  this-curriculum
  "http://bit.ly/2IvXVHJ")

(define-webpage magic-loader-video
  this-curriculum
  "https://bit.ly/2q7YAr3")

(define-starter-code runner1-starter
  starter-files
  "tsgd_runner_1.rkt")

(define-starter-code runner2-starter
  starter-files
  "tsgd_runner_2.rkt")

(define-starter-code runner3-starter
  starter-files
  "tsgd_runner_3.rkt")

(define-starter-code runner4-starter
  starter-files
  "tsgd_runner_4.rkt")


(define open-file
  (activity-instructions "Open Your File"
                         '()
                         (list (instruction-basic "Open your SAVE_MY_WORK folder")
                               (instruction-basic "Double-click your .rkt file")
                               (instruction-folder "~/Desktop/SAVE_MY_WORK")
                               (instruction-goal "your file open in DrRacket."))
                         (vc-append
                          FOLDER_ICON
                          (t "SAVE_MY_WORK"))))


;(define open-piskel
;  (activity-instructions "Open Piskel"
;                         '()
;                         (list (instruction-open "Piskel")
;                               (instruction-goal "Piskel and demonstrate one tool."))
;                         (video-qr "http://bit.ly/2nqVGPc")))

(define (draw-sprite image sprite)
  (activity-instructions (++ "Draw Your " (string-titlecase sprite))
                         '()
                         (list (instruction-open "Piskel")
                               (instruction-basic (++ "Paint a " (string-downcase sprite) " for your game."))
                               (instruction-goal "your completed texture."))
                         (scale (local-bitmap image) 2.0)))


(define-launcher-function import-image
  (thunk (local-bitmap "piskel-import.png")))


(define (import-to-piskel sprite)
  (activity-instructions (++ "Import Your " (string-titlecase sprite))
                         '()
                         (list
                          (instruction-open "Piskel")
                          (instruction-basic "Click on the Import icon.")
                          (instruction-basic (++ "Select 'Browse Images' and open your image."))
                          (instruction-goal "your image imported into piskel."))
                        (launcher-img import-image)))


(define test-game
  (activity-instructions "Test the Game"
                         '()
                         (list
                          (instruction-basic "Save your code.")
                          (instruction-basic "Click 'Run' to test the game.")
                          (instruction-goal "your new changes running in game."))
                        (scale-to-fit (local-bitmap "click_run.png") 250 250 #:mode 'preserve)))



;load code snippet
(define (load-new-code demo-name)
  (activity-instructions "Load the New Code"
                         '()
                         (list (instruction-basic "Use the launcher to get some free code!")
                               (instruction-goal  "The new code in DrRacket"))
                         (launcher-img demo-name)))

(define (change-columns-img)


  (define columns (code 3))
  
  (define code-img
    (code (define player-sprite
              (sheet->sprite #,(code-align (scale (random-dude) 0.25))
                             #:columns  #,columns))))

  (code+hints code-img
              (list columns (hint (text "This should not be 3.  Experiment.")))))

(define-launcher-function change-columns
  change-columns-img)


(define-syntax-rule (replace-sprite-step-1 def)
  (let-values ([(main hint-targets)
                (try-smw-and-then "tsgd_runner_1.rkt"
                                  (change-sprite-for-defined-constant def))])

    (code+hints main
                (list (first hint-targets) (hint (text "Delete this."))))))

(define (replace-sprite-step-2)
  (bitmap (build-path images "insert-image-menu.png")))



(define-launcher-function replace-player-sprite
  (thunk
   (vl-append 10
              (t "Step 1: Delete current sprite")
              (replace-sprite-step-1 player-sprite-definition)
              (t "Step 2: Insert > Insert Image...")
              (replace-sprite-step-2)
              (t "Step 3: Find your sprite; Open it."))))

(define-launcher-function replace-item-sprite
  (thunk
   (vl-append 10
              (t "Step 1: Delete current sprite")
              (replace-sprite-step-1 item-sprite-definition)
              (t "Step 2: Insert > Insert Image...")
              (replace-sprite-step-2)
              (t "Step 3: Find your sprite; Open it."))))




(define (replace-sheet thing l)
  (activity-instructions (~a "Replace Your " thing)
                         '()
                         (list
                          (instruction-basic "Find and delete the old sprite.")
                          (instruction-basic "Go to 'Insert' menu and select 'Insert Image...'")
                          (instruction-basic "Find your image and select 'Open'")
                          (instruction-goal "your sprite in the code."))
                        (launcher-img l)))


(define-webpage export-video
  this-curriculum
  "http://bit.ly/2Ark1Wv")

(define export-from-piskel
  (activity-instructions "Export the Texture"
                         '()
                         (list (instruction-basic "Export from Piskel to SAVE_MY_WORK.")
                               (instruction-basic "Make sure the file name ends in '.png'")
                               (instruction-goal "your exported file."))
                         (scale-to-fit (local-bitmap "piskel_export.png") 400 350 #:mode 'preserve)))



;; COMPLETE DAYS


(define death-by-fireball-code-img (scale (code (on-collide "fireball" die)) 4 ))





;Syntax helpers for code+hints



(define-syntax-class player-entity-def #:datum-literals (player-entity player-sprite sprite->entity)
  (pattern
   (define (player-entity)
     (sprite->entity player-sprite
                     name-kw:keyword name
                     position-kw:keyword position
                     components:keyword first-component rest ...))))

(define-syntax-class player-entity-call #:datum-literals (player-entity)
  (pattern (player-entity)))

(define-syntax-class start-game-call #:datum-literals (start-game)
  (pattern
   (start-game
    before-player ...
    player:player-entity-call
    after-player ...
    background)))

(define-syntax-class item-sprite-definition #:datum-literals (define item-sprite)
  (pattern
   (define item-sprite
     expr)))

(define-syntax-class player-sprite-definition #:datum-literals (define player-sprite)
  (pattern
   (define player-sprite
     expr)))

(define-syntax-class ground-sprite-definition #:datum-literals (define ground)
  (pattern
   (define ground
     expr)))



(define (most-recently-changed-rkt folder)
  (parameterize ([current-directory folder])
    (define paths (directory-list))
    
    (define mod-times (map file-or-directory-modify-seconds paths))
    (build-path folder
                (path->string (list-ref paths (index-of mod-times (apply max mod-times)))))))

(define (most-recently-changed-smw-rkt)
  (most-recently-changed-rkt (build-path (find-system-path 'home-dir) "Desktop" "SAVE_MY_WORK")))



(define current-file (make-parameter #f))


(define (add-to-player-entity-components thing)
 
  (define extracted-snippet
    (extract-from-file (current-file) ;Here's where we could get the users file??
                       player-entity-def))


  ;Now we inject the SNIPE datum in exactly the right spot..
  (define extracted-snippet-transformed
    (syntax-parse extracted-snippet
      [p:player-entity-def
       #`(define (player-entity)
           (sprite->entity player-sprite
                           p.name-kw p.name
                           p.position-kw p.position
                           p.components p.first-component p.rest ...
                           #,(datum->syntax #f 'SNIPE #'p.first-component)))]
      [other #'nope]))

  ;Now we replace the SNIPE datum and generate the images for code+hints
  (typeset-with-targets extracted-snippet-transformed
                          (list 'SNIPE
                                (replace-with thing))))





(define (add-to-start-game thing)

  (define extracted-snippet
    (extract-from-file (current-file)
                       start-game-call))


  ;Now we inject the SNIPE datum in exactly the right spot..
  (define extracted-snippet-transformed
    (syntax-parse extracted-snippet
      [s:start-game-call
       #`(start-game
          s.before-player ...
          s.player
          #,(datum->syntax #f 'SNIPE #'s.background)
          s.after-player ...
          s.background)]
      [other #'nope]))

  ;Now we replace the SNIPE datum and generate the images for code+hints
  (typeset-with-targets extracted-snippet-transformed
                        (list 'SNIPE
                              (replace-with thing))))


;Must be syntax rule because def is a syntax-class?  Can't pass those around as values...
(define-syntax-rule (change-defined-constant def old-id new-id)
  (let [( extracted-snippet
          (extract-from-file (current-file)
                             def))]

    (typeset-with-targets extracted-snippet
                          (list old-id
                                (replace-with new-id)))))


(define-syntax-rule (find-defined-constant def)
  (let [(extracted-snippet
          (extract-from-file (current-file)
                             def))]


    (typeset-with-targets extracted-snippet)))


(define-syntax-rule (change-sprite-for-defined-constant def)
 (let [(extracted-snippet
         (extract-from-file (current-file) ;Here's where we could get the users file??
                            def))]

    (typeset-with-targets extracted-snippet
                          (list h:image? delete-this))))


(define-syntax-rule (wrap-image-within def
                                       wrapper-code)

  (let [(extracted-snippet
         (extract-from-file (current-file) ;Here's where we could get the users file??
                            def))]

    (typeset-with-targets extracted-snippet
                          (list h:image? (wrap-with wrapper-code)))))


(define-syntax-rule (try-smw-and-then file expr)
  
  (letrec-values ([(problem?) #f]
               [(main hints)
                (with-handlers ([exn:fail? (lambda(e)
                                             (set! problem? #t)
                                             (parameterize
                                               ([current-file (build-path starter-files file)])
                                             expr))])
                  (parameterize ([current-file (most-recently-changed-smw-rkt)])
                    expr))])

    (and problem?
         (displayln (~a
                     "NOTE: There's something wrong with your file: " (most-recently-changed-smw-rkt) ".  You should fix it before you go on.")))
    
    (values main hints)

    ))

