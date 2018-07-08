generic 
   type elem is private;
   type key_component is (<>);
   type key_index is range <>;
   type key is array(key_index) of key_component;
   
package dtrie is   
   
   type trie is limited private;
   
   overflow: exception;
   elem_does_not_exist: exception;
   
   procedure t_empty(t: out trie);
   procedure t_put(t: in out trie; k: in key; x: in elem);
   function t_exists(t: in trie; k: in key)return boolean;
   procedure t_delete(t: in out trie; k: in key);
   function t_is_empty(t: in trie) return boolean;
   procedure t_get(t: in trie; k: in key; x: out  elem);
   
   type iterator is private;
   
   bad_use: exception;
   
   procedure i_first (t: in trie; it: out iterator);
   procedure i_next (t: in trie; it: in out iterator);
   function i_is_valid (it: in iterator) return boolean;
   procedure i_get (t: in trie; it: in iterator; k: out key);
   
private
   type cell;
   type pcell is access cell;
   type TCELL is (INTERIOR, LEAF);
   type apcell is array(key_component) of pcell;
   type cell (t: TCELL) is record
      case t is 
         when INTERIOR => 
            ti: apcell;
         when LEAF => 
            tc: elem;
      end case;
   end record;
   
   type trie is record
      root: pcell;
   end record;
   
   type path is array (key_index) of pcell;
   type iterator is record
      pth : path;
      k : key;
      i : key_index;
   end record;
   
end dtrie;
