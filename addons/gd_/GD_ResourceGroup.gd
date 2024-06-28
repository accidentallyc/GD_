extends Node

var tracked:EntangledLinkedListItem
var count = 0

const GOAL = 60 # 60 checks per second gated by delta
var goal = 0 # this gets set during the an entangle, so we can avoid shortcircuits in _process

## "Entangles" the lifespan of a node with another node.
## If that other node is garbage collected, we garbage collect the entanglees
## as well
func entangle(ref:RefCounted, entanglees:Array[Object]):
    var item = EntangledLinkedListItem.new()
    item.ref = weakref(ref)
    item.entanglees = entanglees
    if not tracked:
        item.next = item
        item.prev = item
    else:
        item.next = tracked
        item.prev = tracked.prev
        tracked.prev = item
    tracked = item
    entangle.call_deferred()
    count += 1
    goal = GOAL # kick starts

func _process(delta):
    var num_calls = roundi(goal * delta)
    
    # For every "_process" tick we just carousel around the entangled components
    # Check if they are entangled and then delete the entanglees if its been GCed
    #
    # We multiply against delta so we check fewer times when the computer
    # is struggling
    for i in num_calls:
        var cursor = tracked
        
        if not cursor: return
        
        # Rotate to the next tracked to check
        tracked = cursor.next 
        
        if cursor.ref.get_ref() == null:
            for tmp in cursor.entanglees:
                tmp.queue_free()
            cursor.prev.next = tracked
            cursor.free()
            count -= 1
       
class EntangledLinkedListItem:
    extends Object
    
    var ref:WeakRef
    var entanglees:Array[Object]
    var next: EntangledLinkedListItem
    var prev: EntangledLinkedListItem
