# Bin Truck Simulator
A simulation of a bin truck moving on a square-based neighborhood

## Instructions
1. To run the main file
```
$ ruby main.rb
```
then follow the instructions shown in the console

2. To run unit-test for Bin Truck
```
$ ruby tests/tc_bin_truck.rb
```

## Key design thoughts
1. Create 2 classes BinTruck and Neighborhood to represent 2 actual objects respectively. Structuring classes like this makes it easier to maintain later, in case the requirement changes (eg. changing size of the Neighborhood)
  * BinTruck class has public methods corresponding to the actual actions of a Bin Truck (park, drive, turn_left, turn_right, pickup, callcentral)
  * Neighborhood class is used to initialize a square-based area of arbitrary size.
2. Create a separate module for exceptions to make it easier to manage, and also easy to maintain when the program is scaled
3. Use Rubocop for formatting and cleaning code
4. Write unit-test for BinTruck class. I didnt write test for Neighborhood class because its just a simple class with a simple constructor. If Neighborhood class becomes more complex in the future, its necsessary to write unit-test for it.
5. Use the @inside_area boolean variable in the BinTruck class as a flag to ensure discarding all commands in the sequence until a valid PARK command has been executed.
