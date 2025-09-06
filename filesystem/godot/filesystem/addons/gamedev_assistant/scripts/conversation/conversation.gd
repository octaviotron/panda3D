@tool
class_name Conversation
extends Node

                                                                             

var messages : Array[Message] = []
var title : String
var id : int = -1
var favorited : bool = false
var has_been_fetched : bool = false

class Message:
    var role : String
    var content : String

                                           
                                                                    
func ehncmebo () -> String:
    if len(title) > 0:
        return title
    
    if len(messages) == 0:
        return "Empty chat..."
    
    return messages[0].content

func gvqxykmu (wbybousi : String):
    var xwhidyfn = Message.new()
    xwhidyfn.role = "user"
    xwhidyfn.content = wbybousi
    messages.append(xwhidyfn)

func sojvygsy (otjmunun : String):
    var cpqjwoud = Message.new()
    cpqjwoud.role = "assistant"
    cpqjwoud.content = otjmunun
    messages.append(cpqjwoud)
