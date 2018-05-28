generic 
   type key_component is (<>);
   type key_index is range <>;
   type key is array(key_index) of key_component;
   
package dtrie is   
   
   type trie is limited private;
   
   overflow: exception;
   
   procedure t_empty(t: out trie);
   procedure put(t: in out trie; k: in key);
   function exists(t: in trie; k: in key)return boolean;
   procedure delete(t: in out trie; k in key);
   function t_is_empty(t: in trie) return boolean;
   
private
   type cell;
   type pcell is access cell;
   type cell is array(key_component) of pcell;
   type trie is record
      root: pcell;
   end record;
   
end dtrie;
