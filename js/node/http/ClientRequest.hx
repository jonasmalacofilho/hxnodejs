package js.node.http;

import js.node.stream.Writable;

/**
	Enumeration of events emitted by `ClientRequest`
**/
@:enum abstract ClientRequestEvent(String) to String {
	/**
		Emitted when a response is received to this request. This event is emitted only once.
		Listener arguments:
			* response : IncomingMessage
	**/
	var Response = "response";

	/**
		Emitted after a socket is assigned to this request.
		Listener arguments:
			* socket : Socket
	**/
	var Socket = "socket";

	/**
		Emitted each time a server responds to a request with a CONNECT method.
		If this event isn't being listened for, clients receiving a CONNECT method
		will have their connections closed.

		Listener arguments:
			* response : IncomingMessage
			* socket : Socket
			* head : Buffer
	**/
	var Connect = "connect";

	/**
		Emitted each time a server responds to a request with an upgrade.
		If this event isn't being listened for, clients receiving an upgrade header
		will have their connections closed.

		Listener argument:
			* response : IncomingMessage
			* socket : Socket
			* head : Buffer
	**/
	var Upgrade = "upgrade";

	/**
		Emitted when the server sends a '100 Continue' HTTP response,
		usually because the request contained 'Expect: 100-continue'.
		This is an instruction that the client should send the request body.
	**/
	var Continue = "continue";
}

/**
	This object is created internally and returned from `Http.request`.

	It represents an in-progress request whose header has already been queued.
	The header is still mutable using the `setHeader`, `getHeader` and `removeHeader`.
	The actual header will be sent along with the first data chunk or when closing the connection.

	To get the response, add a listener for 'response' to the request object.
	'response' will be emitted from the request object when the response headers have been received.
	The 'response' event is executed with one argument which is an instance of `IncomingMessage`.

	During the 'response' event, one can add listeners to the response object;
	particularly to listen for the 'data' event.

	If no 'response' handler is added, then the response will be entirely discarded.
	However, if you add a 'response' event handler, then you must consume the data from the response object,
	either by calling `read` whenever there is a 'readable' event, or by adding a 'data' handler, or by calling
	the `resume` method. Until the data is consumed, the 'end' event will not fire. Also, until the data is read
	it will consume memory that can eventually lead to a 'process out of memory' error.

	Note: Node does not check whether 'Content-Length' and the length of the body which has been transmitted are equal or not.
**/
extern class ClientRequest extends Writable<ClientRequest> {

	/**
		Get header value
	**/
	function getHeader(name:String):String;

	/**
		Set header value.

		Headers can only be modified before the request is sent.
	**/
	function setHeader(name:String, value:String):Void;

	/**
		Remove header

		Headers can only be modified before the request is sent.
	**/
	function removeHeader(name:String):String;

	/**
		Aborts a request.
	**/
	function abort():Void;

	/**
		Once a socket is assigned to this request and is connected
		`socket.setTimeout` will be called.
	**/
	function setTimeout(timeout:Int, ?callback:Void->Void):Void;

	/**
		Once a socket is assigned to this request and is connected
		`socket.setNoDelay` will be called.
	**/
	function setNoDelay(?noDelay:Bool):Void;

	/**
		Once a socket is assigned to this request and is connected
		`socket.setKeepAlive`() will be called.
	**/
    @:overload(function(?initialDelay:Int):Void {})
    function setSocketKeepAlive(enable:Bool, ?initialDelay:Int):Void;
}
