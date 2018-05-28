generic
   type elem is private;

package dqueue_pointers is
   
   type queue is limited private;
   
   bad_use: exception;
   overflow: exception;
   
   
   procedure empty(q: out queue);
   procedure add(q: in out queue; x: in elem);
   procedure delete_first(q: in out queue);
   function get_first(q: in queue) return elem;
   function is_empty(q: in queue) return boolean;  
   function is_last_item(q: in queue) return boolean;
   
private
   
   type cell;
   
   type pcell is access cell;
   
   type cell is record
      
      e: elem;
      next: pcell;
      
   end record;
   
   type queue is record
      
      first, last: pcell;
      
   end record;

end dqueue_pointers;
