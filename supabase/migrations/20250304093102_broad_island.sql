/*
  # Fix order deletion cascade

  1. Changes
     - Add proper ON DELETE CASCADE constraints to order_items table
     - Fix foreign key references
     - Add delete policies for orders and order_items tables

  2. Security
     - Add policies for authenticated users to delete orders and order items
*/

-- Drop existing foreign key constraint if it exists
ALTER TABLE order_items 
DROP CONSTRAINT IF EXISTS order_items_order_id_fkey;

-- Add proper ON DELETE CASCADE constraint
ALTER TABLE order_items
ADD CONSTRAINT order_items_order_id_fkey
FOREIGN KEY (order_id) 
REFERENCES orders(id)
ON DELETE CASCADE;

-- Add delete policies for orders
DROP POLICY IF EXISTS "Enable delete access for authenticated users" ON orders;
CREATE POLICY "Enable delete access for authenticated users"
  ON orders
  FOR DELETE
  TO authenticated
  USING (true);

-- Add delete policies for order_items
DROP POLICY IF EXISTS "Enable delete access for authenticated users" ON order_items;
CREATE POLICY "Enable delete access for authenticated users"
  ON order_items
  FOR DELETE
  TO authenticated
  USING (true);