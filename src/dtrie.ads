generic 
   type elem is private;
   type key_component is (<>);
   type key_index is range <>;
   type key is array(key_index) of key_component;
   
package dtrie is   
   
   type trie is private;
   
   overflow: exception;
   
   procedure t_empty(t: out trie);
   procedure t_put(t: in out trie; k: in key; x: in elem);
   function t_exists(t: in trie; k: in key)return boolean;
   procedure t_delete(t: in out trie; k: in key);
   function t_is_empty(t: in trie) return boolean;
   
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
   
end dtrie;
