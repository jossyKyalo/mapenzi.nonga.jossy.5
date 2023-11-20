

; Defining a template for tomato diseases
(deftemplate tomato-disease
   (slot name)
   (slot symptoms)
   (slot treatment)
)

; Adding facts for tomato diseases
(deffacts tomato-disease-facts
   (tomato-disease (name early-blight)
                  (symptoms "yellowing leaves, dark spots")
                  (treatment "fungicide spray"))
   (tomato-disease (name late-blight)
                  (symptoms "wilting, brown spots")
                  (treatment "copper-based fungicide"))
   (tomato-disease (name blossom-end-rot)
                  (symptoms "dark, sunken spots at the blossom end")
                  (treatment "calcium supplementation"))
   (tomato-disease (name powdery-mildew)
                  (symptoms "white powdery patches on leaves")
                  (treatment "sulfur-based fungicide"))
   ; Add more disease facts here
)

(defrule tomato-menu
   =>
   (printout t "Please indicate if any part of your tomato plant is affected. Use 1 for 'Yes' or 2 for 'No'." crlf)
   (printout t "   Are the Leaves Affected? (1 for Yes, 2 for No)" crlf)
   (printout t "Your choice: ")
   (bind ?leaves (read))
   (assert (leaves ?leaves))
   (printout t " " crlf)

   (printout t "   Are the Stems Affected? (1 for Yes, 2 for No)" crlf)
   (printout t "Your choice: ")
   (bind ?stems (read))
   (assert (stems ?stems))
   (printout t " " crlf)

   (printout t "   Are the Fruits Affected? (1 for Yes, 2 for No)" crlf)
   (printout t "Your choice: ")
   (bind ?fruits (read))
   (assert (fruits ?fruits))
   (printout t " " crlf)

   (printout t "   Are the Roots Affected? (1 for Yes, 2 for No)" crlf)
   (printout t "Your choice: ")
   (bind ?roots (read))
   (assert (roots ?roots))
   (printout t " " crlf)
)

; Rules for diagnosing and controlling tomato diseases
(defrule tomato-leaves-diseases
   (leaves 1)
   =>
   (printout t "You've observed small, reddish-brown lesions on the upper side of the leaves.") ; Tomato Leaf Rust
   (printout t "Please enter 1 if you observed these characteristics or 0 if not." crlf)
   (printout t "Your choice: ")
   (bind ?leaves (read))
   (assert (leaves ?leaves))

   (printout t "You've noticed white, powdery spots on the leaves and stems.") ; Powdery Mildew
   (printout t "Please enter 2 if you observed these characteristics or 0 if not." crlf)
   (printout t "Your choice: ")
   (bind ?leaves (read))
   (assert (leaves ?leaves))

   (printout t "There are small, tan to brown spots with dark borders on the leaves.") ; Tomato Tan Spot
   (printout t "Please enter 3 if you observed these characteristics or 0 if not." crlf)
   (printout t "Your choice: ")
   (bind ?leaves (read))
   (assert (leaves ?leaves))
)

; Rules for diagnosing tomato diseases based on symptoms
(defrule diagnose-tomato
   (leaves 1)
   =>
   (printout t "Based on the observed symptoms, it might be one of the following diseases:" crlf)
   (printout t "1. Early Blight" crlf)
   (printout t "2. Late Blight" crlf)
   (printout t "3. Blossom-end Rot" crlf)
   (printout t "4. Powdery Mildew" crlf)
   (printout t "Please enter the corresponding number to continue diagnosis: ")
   (bind ?disease-choice (read))
   (assert (disease-choice ?disease-choice))
   (printout t crlf)
)

; Suggesting treatment for diagnosed tomato diseases
(defrule MAIN suggest-treatment
   ?disease-choice <- (disease-choice ?choice)
   ?disease <- (tomato-disease (name ?name))
   (test (eq (str-compare ?name ?choice) 0))
   =>
   (printout t "Recommended treatment for " ?name " is: " (send ?disease ?treatment) crlf)
   (printout t "If the symptoms match, follow the provided treatment recommendation." crlf)
   (printout t "If not, please consult a local agricultural expert
