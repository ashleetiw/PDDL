(define (domain sokorobotto)
  (:requirements :typing )
  (:types 
        pallette robot - agent
        location - position
        shipment order saleitem - object
  )
		  
  (:predicates 
              (ships ?z - shipment ?o - order)
              (orders ?o - order ?s - saleitem)
              (packing-location ?x - position)
              (contains ?p - pallette ?s - saleitem)
              (at ?p - agent ?x - position)
              (includes ?z - shipment ?s - saleitem)
              (unstarted ?z - shipment)
              (available ?x - position)
              (free ?r - robot)
              (connected ?x ?x - position)
              (no-robot ?x - position)
              (no-pallette ?x - position)
  )

  (:action getpallette
    :parameters (?r - robot ?palletteloc ?roboloc - position ?p - pallette)
    :precondition (and  ;state
               (not(at ?r ?palletteloc)) (no-robot ?palletteloc) (at ?p ?palletteloc)  ; at pallette location
                (at ?r ?roboloc) (not(no-robot ?roboloc)) (not(at ?p ?roboloc)) (no-pallette ?roboloc) ; robot location
                (connected ?roboloc ?palletteloc)
    )
    :effect (and 
    (at ?r ?palletteloc) (not(no-robot ?palletteloc)) (at ?p ?palletteloc) (not(no-pallette ?palletteloc)) ; at pallette location
    (not(at ?r ?roboloc)) (no-robot ?roboloc) ; robot location  
    (available ?roboloc)
    )
    )
  
  (:action movetopacklocationwithpallette
      :parameters (?r - robot ?palletteloc ?packloc - position ?p - pallette)

      :precondition (and  
                (at ?r ?palletteloc) (at ?p ?palletteloc) (not (no-robot ?palletteloc)) (not (no-pallette ?palletteloc)) ;pallectlocation
                (available ?packloc) (no-robot ?packloc) (no-pallette ?packloc) (not (at ?r ?packloc)) (not (at ?p ?packloc)) ;packing location
                (packing-location ?packloc)(connected ?palletteloc ?packloc) (connected ?packloc ?palletteloc))  ; condition
      :effect (and
          (no-robot ?palletteloc) (not (at ?r ?palletteloc)) (no-pallette ?palletteloc) (not (at ?p ?palletteloc)) ;pallectlocation
          (at ?r ?packloc) (not (no-robot ?packloc)) (at ?p ?packloc) (not (no-pallette ?packloc)) ;packing location
		  (not (available ?packloc))  (not(free ?r)) ; condition
      ; (available ?palletteloc)  
          
      )
  )
  
  (:action load
      :parameters (?z - shipment ?s - saleitem ?o - order ?r - robot ?p - pallette ?packloc - location)

      :precondition (and (contains ?p ?s) (orders ?o ?s) (ships ?z ?o) 
                        (at ?r ?packloc) (at ?p ?packloc)  (not (no-robot ?packloc))  (not (no-pallette ?packloc))  ;packing location
                        (packing-location ?packloc))  ;condition
      :effect (and
          (not (contains ?p ?s))
          (includes ?z ?s)
            (at ?r ?packloc) (at ?p ?packloc)  (not (no-robot ?packloc))  (not (no-pallette ?packloc))  ;packing location
            (free ?r)  (not(unstarted ?z )) 
      )
  )
  
  (:action movetoplaceotherthanpallettelocation   ; movinig without pallette so robot is free
        :parameters (?roboloc ?loc1 - position ?p - pallette ?r -robot )

        :precondition (and 
                  (at ?r ?roboloc)  (not(no-robot ?roboloc))  ; robo location
                    (no-robot ?loc1) (not(at ?r ?loc1)) (no-pallette ?loc1) (not(at ?p ?loc1)) 
                      (connected ?roboloc ?loc1)(connected ?loc1 ?roboloc)
        )
        :effect (and 
                (not(at ?r ?roboloc)) (no-robot ?roboloc) 
                 (not(no-robot ?loc1)) (at ?r ?loc1) 
                ;  (available ?roboloc)
        )
    )

  (:action droppallette  ; case when robot gets free 
    :parameters (?r - robot ?palletteloc ?loc1 - position ?p - pallette)
    :precondition (and 
                (at ?r ?palletteloc)  (not(no-robot ?palletteloc)) (at ?p ?palletteloc) (not(no-pallette ?palletteloc)) ; at pallette location
                (not(at ?r ?loc1)) (no-robot ?loc1) ; robot location
                (connected ?palletteloc ?loc1)  ; condition
    )
    :effect (and 
     (not(at ?r ?palletteloc)) (no-robot ?palletteloc)  ; at pallette location
     (at ?r ?loc1) (not(no-robot ?loc1)) ; new location  
     (free ?r)
    )
    )
  
  (:action movewithpallettelocationotherthanpackingloc
      :parameters (?r - robot ?palletteloc ?loc1 - position ?p - pallette)

      :precondition (and  
                    (at ?r ?palletteloc) (at ?p ?palletteloc) (not (no-robot ?palletteloc)) (not (no-pallette ?palletteloc)) ;pallette location
					(no-robot ?loc1) (no-pallette ?loc1) (not(at ?r ?loc1)) (not(at ?p ?loc1))  ; new location
                    (connected ?palletteloc ?loc1)  (not (packing-location ?palletteloc)) (not (packing-location ?loc1)) ;condition
                    
                )
      :effect (and
          (at ?r ?loc1) (at ?p ?loc1) (not (no-robot ?loc1)) (not (no-pallette ?loc1)) ;new location
           (no-robot ?palletteloc) (no-pallette ?palletteloc) (not (at ?r ?palletteloc)) (not (at ?p ?palletteloc)) ; condition
          (available ?palletteloc)
      )
  )
  
  (:action clearpacklocation
      :parameters (?z - shipment ?r - robot ?packloc ?loc1 - position ?p - pallette)
      :precondition (and 
                    (at ?r ?packloc) (at ?p ?packloc)  (not (no-robot ?packloc))  (not (no-pallette ?packloc));packloc
                    (no-robot ?loc1) (no-pallette ?loc1) (not(at ?r ?loc1)) (not(at ?p ?loc1)) ; new location
                    (packing-location ?packloc) (connected ?packloc ?loc1)  ;condition

      ) 
      :effect (and (unstarted ?z )
          (at ?r ?loc1) (at ?p ?loc1)(not (no-robot ?loc1)) (not (no-pallette ?loc1)) ;new location
		  (no-robot ?packloc)(no-pallette ?packloc)(not (at ?r ?packloc))(not (at ?p ?packloc)) ; packing location
          (available ?packloc) ; condition
		  
      )
  )
)