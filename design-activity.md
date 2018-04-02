#Hotel Revisited
*****
### Questions for Online Shopping Cart Code Implementations:
* What classes does each implementation include? Are the lists the same?
  - Both implementations have the same classes: CartEntry, ShoppingCart, and Order.
* Write down a sentence to describe each class.
  - CartEntry appears to be a class for containing information about a specific item or product.
  - ShoppingCart appears to be a class that stores a list of items or products.
  - Order appears to be class for calculating total cost of the ShoppingCart, including SALES_TAX.
* How do the classes relate to each other? It might be helpful to draw a diagram.
  - There doesn't appear to be any explicit relationship between the CartEntry and any of the other classes, but I would assume a ShoppingCart could potentially have one or more CartEntry instances.
  - An instance of a Order within this implementation has-a ShoppingCart.
* What data does each class store? How (if at all) does this differ between the two implementations?
  - The appears to be no difference between the two implementations for the data each class stores: CartEntry stores the \@quantity (of the product) and \@unit_price (cost per product), ShoppingCart stores \@entries (a list of some entries, in this code, like CartEntry instances), and Order stores \@cart (a ShoppingCart) and the constant, SALES_TAX.
* What methods does each class have? How (if at all) does this differ between the two implementations?
  - Each implementation as an initialize method for the three classes.
  - Implementation A: uses helper methods in each "lower level" class, CartEntry and ShoppingCart. Then, Order#total_price calculates the sum all entries together and adds on sales tax.
  - Implementation B: uses no helper methods in any class. Instead, CartEntry and ShoppingCart have price instance methods that calculate the their own prices. Then, Order only has to add the sales tax cost to the price in Order#total_price.
* Consider the Order#total_price method. In each implementation:
  * Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
    - In Implementation A, I would say the logic is solely retained in Order.
    - In Implementation B, the logic is shared between all three classes, as such delegated to the "lower level" classes: ShoppingCart and CartEntry.
  * Does total_price directly manipulate the instance variables of other classes?
    - In Implementation A, yes, it does (helper methods).
    - In Implementation B, no, it does not seem to.
* If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  - You would need to add some conditional if quantity > some_amount then unit_price = unit_price * some_discount. This code could be added into the each loop of total_price for Implementation A or the instance method for price of CartEntry in Implementation B.
  - As far as difficulty to modify the code to make this possible, I think it would be possible to apply to either method just as easily. It also depends on how complicated the discount logic is. You would need some type of discount for above a certain quantity. If the discount is the same no matter what the item, either method can be changed as easily as the other. If the discount is changes item to item, I think it would be easier to change Implementation B.
* Which implementation better adheres to the single responsibility principle?
  - I believe Implementation B adheres better. The Order doesn't have to the responsibility of calculating each CartEntry price then summing all the Entries in the ShoppingCart together to then add on sales tax.
* Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  - Also, Implementation B. It doesn't have to call on the instance variables of CartEntry or ShoppingCart to find the total price for the order.
*****
### The Hotel Revision
I had a few unnecessary helper methods, so want to change the code, so the classes only have access to the ids of the other classes. This means changing the code so Room doesn't respond to :calendar or :cost, Reservation doesn't respond to :room or :date_range, and Block doesn't respond to :reservations. This is better because if later I change all the information in a class, I can just change that method within the class and the other classes wont know what know any different as long as it is getting the information it needs.

To revise Hotel, I changed the initialize arguments for Block and Reservation to take a hash instead of separate arguments. I changed the way the classes assign and track ids. Then, I worked on changing all the different classes approach to instance variables of other classes, so that except for ids and room_num, the other classes don't know too much about the others. (hopefully)
