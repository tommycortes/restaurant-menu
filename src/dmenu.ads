with dtrie;
with dqueue_pointers;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package dmenu is
   type menu is limited private;
   type tcategory is (STARTER, MAIN, SECOND, DESSERT, DRINK);
   type tcalification is (GREAT, GOOD, BAD);
   
   subtype trie_component is Character range '@'..'Z';
   subtype trie_index is Natural range 1..4;
   type tkey is array(trie_index) of trie_component;

   procedure m_empty(m: out menu);
   procedure m_put(m: in out menu; cat: in tcategory; k: in tkey; name: in Unbounded_String);
   procedure m_print(m: in menu; cat: in tcategory);
   procedure m_delete_element(m: in out menu; cat: in tcategory; k: in tkey);
   procedure m_put_comment(m: in out menu; cat: in tcategory; k: in tkey; c: in tcalification; comment: in Unbounded_String);
   function m_read_comment(m: in out menu; cat: in tcategory; k: in tkey; c: in tcalification) return Unbounded_String;
   function m_exists_comment(m: in out menu; cat: in tcategory; k: in tkey; c: in tcalification) return Boolean;
   procedure m_delete_comment(m: in out menu; cat: in tcategory; k: in tkey; c: in tcalification);
   
private
   
   package comment_queue is new dqueue_pointers(Unbounded_String); use comment_queue;
   --type pqueue is access queue;
   type comment_queue_array is array (tcalification) of queue;
   
   type course is record
      name: Unbounded_String;
      comments: comment_queue_array;
   end record;
   type pcourse is access course;
   
   package course_trie is new dtrie(pcourse, trie_component, trie_index, tkey); use course_trie;
   
   type menu is array(tcategory) of trie;   

end dmenu;
