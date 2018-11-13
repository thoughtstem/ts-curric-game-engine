#lang slideshow


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

         this-curriculum
         images
         starter-files)

(require racket/runtime-path)

(require pict/code)
(require ts-curric-common)
(require (except-in ts-racket scale-to-fit))

(require racket/runtime-path)

(define-runtime-path images        "images")
(define-runtime-path starter-files "starter-files")

(define-runtime-path this-curriculum ".")

(define (local-avatar s)
  (avatar (~a (path->string images) "/" s)))

(define (local-bitmap s)
  (bitmap (~a (path->string images) "/" s)))


(define MARIO        (circlify "blue" (local-avatar "mario")))
(define MARIO-BONUS  (circlify "red" (local-avatar "mario")))
(define PACMAN       (circlify "blue" (local-avatar "pacman")))
(define PACMAN-BONUS (circlify "red" (local-avatar "pacman")))
(define G-MUSH       (circlify "blue" (local-avatar "greenMushroom")))
(define G-MUSH-BONUS (circlify "red" (local-avatar "greenMushroom")))
(define R-MUSH       (circlify "blue" (local-avatar "redMushroom")))
(define R-MUSH-BONUS (circlify "red" (local-avatar "redMushroom")))
(define STAR         (circlify "blue" (local-avatar "star")))
(define STAR-BONUS   (circlify "red" (local-avatar "star")))
(define LINK         (circlify "blue" (local-avatar "link")))
(define LINK-BONUS   (circlify "red" (local-avatar "link")))
(define SAMUS        (circlify "blue" (local-avatar "samus")))
(define SAMUS-BONUS  (circlify "red" (local-avatar "samus")))
(define PIKACHU          (circlify "blue" (local-avatar "pikachu")))
(define PIKACHU-BONUS    (circlify "red" (local-avatar "pikachu")))
(define CHARMANDER       (circlify "blue" (local-avatar "charmander")))
(define CHARMANDER-BONUS (circlify "red" (local-avatar "charmander")))
(define SQUIRTLE         (circlify "blue" (local-avatar "squirtle")))
(define SQUIRTLE-BONUS   (circlify "red" (local-avatar "squirtle")))
(define YOSHI         (circlify "blue" (local-avatar "yoshi")))
(define YOSHI-BONUS   (circlify "red" (local-avatar "yoshi")))
(define SONIC         (circlify "blue" (local-avatar "sonic")))
(define SONIC-BONUS   (circlify "red" (local-avatar "sonic")))

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


(define-image-file import-image
  images
  (local-bitmap "piskel-import.png"))


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

(define-image-file change-columns
  images
  (change-columns-img))


(define (replace-sprite-step-1)
  (define full
    (x-out (bitmap (build-path images "hero-sprite.png"))))

  (define columns (code 3))
  
  (define code-img
    (code (define player-sprite
              (sheet->sprite #,full
                             #:columns  #,columns))))

  (code+hints code-img
              (list full    (hint (text "Delete this.")))))

(define (replace-sprite-step-2)
  (bitmap (build-path images "insert-image-menu.png")))



(define-image-file replace-sprite
  images
  (vl-append 10
   (t "Step 1: Delete current sprite")
   (replace-sprite-step-1)
   (t "Step 2: Insert > Insert Image...")
   (replace-sprite-step-2)
   (t "Step 3: Find your sprite; Open it.")))


(define (replace-sheet thing)
  (activity-instructions (~a "Replace Your " thing)
                         '()
                         (list
                          (instruction-basic "Find and delete the old sprite.")
                          (instruction-basic "Go to 'Insert' menu and select 'Insert Image...'")
                          (instruction-basic "Find your image and select 'Open'")
                          (instruction-goal "your sprite in the code."))
                        (launcher-img replace-sprite)))


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


;(with-award 1 death-by-lava)
(define death-by-fireball-code-img (scale (code (on-collide "fireball" die)) 4 ))


;day 11 Player Shooting and Boss Health



;;; --- "red" = text color for Q#-#

(require (only-in game-engine get-name))

(provide evaluate-game
         game-has-player?
         game-has-chest?
         game-has-bad-chest?)

(define (game-has-chest? e)
  (string=? "chest" (get-name e)))

(define (game-has-bad-chest? e)
  (string=? "bad chest" (get-name e)))

(define (game-has-player? e)
  (or
   (string=? "player" (get-name e))
   (string=? "hero" (get-name e))))

(define (run-test t es)
  (define results (filter t es))
  (or results
      #f))

(define (evaluate-game tests . es)
  (map (curryr run-test es) tests))


