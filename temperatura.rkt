#lang racket

(define (clasificar-temperatura-ambiente t)
  (cond
    [(< t 15) "Temperatura baja"]
    [(and (>= t 15) (<= t 25)) "Temperatura normal"]
    [else "Temperatura alta"]))

(display "Ingrese la temperatura ambiente en grados Celsius: ")
(define temp (read))  

(define resultado (clasificar-temperatura-ambiente temp))

(display "Estado de la temperatura: ")
(display resultado)
(newline)
