#lang racket

;High level goals:
#;(

   Title: Animating sprites

   Main goal: Change collectable to be animated
      * Build animation in Piskel
      * Export to sprite sheet
      * Integrate into file

   Stretch goal: Change player to be animated

   ==== No new stuff, just greater master of the above ====

   Quest-complete goals:  Animate something of your choice, using less scaffolding.
      * Remove starter code scaffold: Create an entire new animated thing (same file)
      * Remove hint card scaffold:    Do it without quests cards


   Mastery goal:  I have animated enough things such that I can now do it without
   any scaffolding.
       * Test your mastery:  Do it in under 5 minutes (not including animation time),
       without hint cards.  You may use an existing file with existing entities.
      
   )

(provide quest3)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")


(define-webpage animate-video
  this-curriculum
  "http://bit.ly/2DLfNKP")

(define-webpage export-sprite-video
  this-curriculum
  "http://bit.ly/2HSkJQN")



(define (insert-sprite-sheet thing replace-sprite)
  (activity-instructions (~a "Insert Your " thing)
                         '()
                         (list (instruction-basic "Find the sprite you want to replace.")
                               (instruction-basic "Delete the image and insert your new Sprite Sheet.")
                               (instruction-basic "Change the COLUMNS to match.")
                               (instruction-goal "your code with the new Sprite Sheet."))
                         (launcher-img replace-sprite)))

(define export-sprite-sheet
  (activity-instructions "Export Your Sprite Sheet"
                         '()
                         (list (instruction-basic "Click Export and PNG")
                               (instruction-basic "Change the number of COLUMNS to match the number of frames you have.")
                               (instruction-basic "Export the image to your SAVE_MY_WORK folder.")
                               (instruction-goal "your Sprite Sheet in your SAVE_MY_WORK folder."))
                         (launcher-img export-sprite-video)))

(define (animate sprite)
  (activity-instructions (++ "Animate Your " (string-titlecase sprite))
                         '()
                         (list (instruction-basic (++ "Duplicate and change frames in Piskel to animate your " (string-downcase sprite)))
                               (instruction-goal (++ "your animated " (string-downcase sprite) " in Piskel.")))
                         (launcher-img animate-video)))


;Animate your Collectible
(define day3-2dgame
  (list
   (with-award 0 open-file)
   (with-award 0 (import-to-piskel "Item")) ;1. Import Collectible
   (with-award 3 (animate "Item")) ;2. Duplicate and Edit Collectible -- change color/bounce/sparkle  (Video)
   (with-award 1 export-sprite-sheet) ;3. Export a Sprite Sheet (set rows and columns)  (Video)
   (with-award 1 (insert-sprite-sheet "Item" replace-item-sprite)) ;5. Insert Sprite Sheet - Change rows and columns to match sprite sheet (Video)
   (with-award 1  test-game)
   ;(with-award 1 redesign-sprite-sheet)
   (choose "any"
           (list
            (with-award 3 (animate "Player")) ;7. BONUS -- Animate the main character
            (with-award 0 export-sprite-sheet)
            (with-award 1 (insert-sprite-sheet "Player" replace-player-sprite))))))

(define s (settings (bg (local-bitmap "bg-arcade.png")) (G-MUSH) (G-MUSH-BONUS) (G-MUSH-BONUS)))

(define (quest3)
  (map shrink (make-picts "red" "Q3-" day3-2dgame s)))

(module+ test
  (analyze-activities day3-2dgame s))



