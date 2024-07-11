-- Create a trigger that decreases the quantity of an item after adding a new order
-- Context: Updating multiple tables for one action from your application
-- can generate issue: network disconnection, crash, etc… to keep your data in a good shape, let MySQL do it for you!
DELIMITER $$
CREATE TRIGGER decrease_quantity_item
AFTER INSERT ON orders FOR EACH ROW
BEGIN
  UPDATE items SET quantity = quantity - NEW.number WHERE name = NEW.item_name;
END $$
DELIMITER ;