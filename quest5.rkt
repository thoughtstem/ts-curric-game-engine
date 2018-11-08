#lang racket

(provide quest5)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")


(define-webpage score-video
  this-curriculum
  "https://bit.ly/2vh0aw0")

(define-webpage copy-paste-video2
  this-curriculum
  "https://bit.ly/2HqIEdA")

(define-webpage modify-win-video
  this-curriculum
  "https://bit.ly/2HsgDlH")

(define-webpage add-score-video
  this-curriculum
  "https://bit.ly/2HlBRCq")

(define-webpage download-video
  this-curriculum
  "https://bit.ly/2Hpg60v")


(define-webpage resize-video
  this-curriculum
  "https://bit.ly/2Jj525O")

(define-webpage insert-background-video
  this-curriculum
  "https://bit.ly/2HmmPww")

(define-racket-file keep-score-code
  starter-files
  "tsgd_keep_score.rkt")

(define-launcher-list keep-score
  keep-score-code
  paste-the-code-above-into-your-file)

                                                 
;(with-award 2 modify-score)
(define modify-score
  (activity-instructions "Modify the Keep Score Code"
                         '()
                         (list
                          (instruction-basic "Change \"hero\" and \"chest\" to match your game.")
                          (instruction-basic "Find the (start-game) code and add (score-entity) after (game-over-screen).")
                          (instruction-basic "Test the game.")
                          (instruction-goal "your score changing in game."))
                        (launcher-img score-video)))



;(with-award 1 copy-paste-keep-score) 
(define copy-paste-keep-score
  (activity-instructions "Copy and Paste the Code"
                         '()
                         (list (instruction-basic "Highlight the new code.")
                               (instruction-basic "Press CTRL+C to COPY.")
                               (instruction-basic "Go back to your project and make a new line BEFORE (define lost?)")
                               (instruction-basic "Press CTRL+V to PASTE.")
                               (instruction-goal "your new code in your project"))
                         (launcher-img copy-paste-video2)))


(define won-code-img (p:scale (p:code (define (won? g e) 
                                    (define score (get-counter (get-entity "score" g)))
                                    (>= score 1000)))
                            4 ))

(define modify-won 
  (activity-instructions "Modify the Win Condition"
                         '()
                         (list                        
                          (instruction-basic "Find the '(define (won?' code.")
                          (instruction-basic "Modify the code to read the counter from score-entity. It should look like this:")
                          (instruction-image won-code-img 640 100 "")
                          ;(instruction-basic "Change 'speed' to 'score'.")
                          ;(instruction-basic "Change 'get-speed' to 'get-counter'.")
                          ;(instruction-basic "Change 'get-entity \"###\"' to 'get-entity \"score\"'.")
                          ;(instruction-basic "Change (>= speed 10) to        (>= score 1000).")
                          (instruction-goal "a score of 1000 in game."))
                        (launcher-img modify-win-video)))



(define add-score-background
  (activity-instructions "Add a Score Background"
                         '()
                         (list (instruction-basic "TS Magic Load: 'tsgd_score_bg'.")
                               (instruction-basic "Copy/Paste the code BEFORE (define (score-entity).")
                               (instruction-basic "Add (score-bg) BEFORE (score-entity) in (start-game).")
                               (instruction-goal "your score background in game."))
                         (launcher-img add-score-video)))




(define download-background
  (activity-instructions "Download a New Background"
                         '()
                         (list
                          (instruction-basic "Open Google Chrome and click 'CC Search'.")
                          (instruction-basic "Find a new background image and save it in SAVE_MY_WORK.")
                          (instruction-goal "your image saved in the folder."))
                         (launcher-img download-video)))



(define open-resize-pinta
  (activity-instructions "Resize the Background"
                         '()
                         (list
                          (instruction-open "Pinta")
                          (instruction-basic "Open the downloaded image.")
                          (instruction-basic "Resize and crop the image to 640 by 480.")
                          (instruction-goal "your resized image in Pinta."))
                         (launcher-img resize-video)))



(define save-insert-background
  (activity-instructions "Save & Insert Background"
                         '()
                         (list
                          (instruction-basic "In Pinta, rename and save the image to SAVE_MY_WORK.")
                          (instruction-basic "In DrRacket, delete the old bg and insert your new one.")
                          (instruction-basic "Test your game.")
                          (instruction-goal "your new background in-game."))
                         (launcher-img insert-background-video)))

;Add a Score Entity
(define day5-2dgame
  (list
   (with-award 0 open-file)
   (with-award 0 (load-new-code keep-score))
   (with-award 1 copy-paste-keep-score)       
   (with-award 2 modify-score)                
   (with-award 2 modify-won)
   (choose "any"
          (list
           (with-award 1 add-score-background)
           (with-award 1 download-background)
           (with-award 2 open-resize-pinta)
           (with-award 2 save-insert-background) 
           ))
   ))

(define (quest5)
  (map shrink (make-picts "red" "Q3-" day5-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))



