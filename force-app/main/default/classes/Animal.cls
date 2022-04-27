/**
 * @description       : 
 * @author            : Rodrigo Balbi - Oktana
 * @group             : 
 * @last modified on  : 04-27-2022
 * @last modified by  : Rodrigo Balbi - Oktana
**/
public with sharing class Animal {

    private String animalType;

    public Animal(String animalType) {
        this.animalType = animalType;
    }

    public void makeNoise() {
        switch on this.animalType{
            when Constants.ANIMAL_LION {
                roar();
            }
            when Constants.ANIMAL_CAT {
                meow();
            }
            when Constants.ANIMAL_HORSE {
                neigh();
            }
            when Constants.ANIMAL_ALLIGATOR {
                hiss();
            }
            when Constants.ANIMAL_BEAR {
                growl();
            }
            when Constants.ANIMAL_COW {
                moo();
            }
            when Constants.ANIMAL_DOG {
                bark();
            }
        }
    }

    public void move() {
        if (this.animalType.equals(Constants.ANIMAL_LION) ||
            this.animalType.equals(Constants.ANIMAL_DOG)) {
            run();
        }
        else if (this.animalType.equals(Constants.ANIMAL_CAT) ||
                 this.animalType.equals(Constants.ANIMAL_BEAR) ||
                 this.animalType.equals(Constants.ANIMAL_COW)) {
            walk();
        }
        else if (this.animalType.equals(Constants.ANIMAL_HORSE)) {
            slide();
        }
        else if (this.animalType.equals(Constants.ANIMAL_ALLIGATOR)) {
            hiss();
        }
    }

    public void swim() {
        if (this.animalType.equals(Constants.ANIMAL_LION) ||
            this.animalType.equals(Constants.ANIMAL_ALLIGATOR) ||
            this.animalType.equals(Constants.ANIMAL_BEAR) ||
            this.animalType.equals(Constants.ANIMAL_DOG)) {
            doSwim();
        }
    }

    private void roar() {
        // roaring behavior here
    }

    private void meow() {
        // meowing behavior here
    }

    private void neigh() {
        // neighing behavior here
    }

    private void hiss() {
        // hissing behavior here
    }

    private void growl() {
        // growling behavior here
    }

    private void moo() {
        // mooing behavior here
    }

    private void bark() {
        // barking behavior here
    }

    private void run() {
        // running behavior here
    }

    private void walk() {
        // walking behavior here
    }

    private void slide() {
        // sliding behavior here
    }

    private void doSwim() {
        // swimming behavior here
    }


}