# Planning using PDDL (Planning Domain Definition Language)

## Warehouse Robots!
_BroadLeaf_ company has a number of fancy pallet-moving robots that can help out in their warehouses. 

The robots are capable of picking up pallets and moving them around 
the warehouse. Strong they might be, dextrous they are not. They can
get the pallets to the unloading area, but they need to rely on humans
to take the specific items off of them. This is typical of the real
world, where robots are _really_ good at parts of tasks that humans
fail at, but they drop the ball completely when it comes to things like 
fine motor control.

\*The "R" stands for "Robotto."

## Functions

*  __domain__ file creates a plan
to solve each of first five problem definitions.

## testing 
The first five test are problems that  domain __needs to be
able to solve__, the sixth and seventh are problems that  domain
should __fail to create a plan for__. This is to help you verify that
you're creating a domain that accounts for things like not 
allowing an individual stock item to be in multiple shipments.

### An Online Editor

You can find an online PDDL (Planning Domain Definition Language) editor [here](
http://editor.planning.domains/#) that you can use to test domain definitions you come up with.


### The Domain File
a (very sparse) domain file is given. It contains the domain
name and the relevant PDDL requirements:

```
(define (domain sokorobotto)
  (:requirements :typing)
  (:types  )
  (:predicates  )
)
```

## On PDDL

1. You may work on your domain PDDL directly in [this](http://editor.planning.domains/#) online PDDL editor.
2. Alternatively, you may choose to work on the PDDL inside an IDE, copying and pasting the PDDL in the online editor before running it using the __Solve__ option.
3. One good IDE to use to work on your PDDL is Visual Studio Code, for which there's a good extension available [here](https://marketplace.visualstudio.com/items?itemName=jan-dolejsi.pddl), which lets you view PDDL predicates and keywords in color.
4. In the online PDDL editor on a #1 in this section, you can use the __File -> Load__ option to load PDDL files.
5. Alternatively, you may copy and paste an entire PDDL in the editor, and it will be auto-saved. You may then create a new file and copy-paste another PDDL, and that will be auto-saved as well. Whether you save files this way or load them from somewhere on your computer, they get added to the active session of the editor. Once files have been added, if you click on the __Solve__ option, it will ask you which file to use as the __Problem__ and which as the __Domain__.
6. Unfortunately, the editor doesn't give the greatest error messages, so you may have to put your debugging hat on get deep into your PDDL to find any problems that cause a plan not to be found.
7. Remember, if you find a plan when one should not be found, that's a problem, but since an error won't be thrown, it may not be easy to debug the issue.
8. When defining __predicates__ in PDDL, every predicate can be defined using the same variables, say, that ?x and ?y, but when the predicates are used to define actions, the variable names cannot be reused. In other words, if ?x is used inside one predicate to denote something of type "fruit," then wherever it's used, it denotes "fruit." If a predicate is designed not to take a fruit as an argument and takes a vegeatable instead, then ?x cannot be used as an argument of that predicate.
9. The same predicate can apply to, say, boxes and tables, as long as both are defined as, say, "object." If the same kind of predicate needs to be defined to act on things of type "box" and things of type "table," then two different predicates will be needed; the same predicate cannot accept arguments of both types. However, one can imagine a predicate that handles both boxes and tables by accepting two arguments, one of type "box," one of type "table."
10. Remember to always think of an action in terms of __preconditions__ and __effects__: respectively the requirements that qualify the action to be taken and the results of the action. Be as detailed as possible to avoid undesired effects, which may be undesired not only in and of themselves, but also because they may prohibit certain preconditions from being met for a subsequent desired action.
