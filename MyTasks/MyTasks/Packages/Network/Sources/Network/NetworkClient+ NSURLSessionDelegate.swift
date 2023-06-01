/*
Refer to these links
 
 https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW33
 
 https://developer.apple.com/documentation/foundation/url_loading_system/handling_an_authentication_challenge/performing_manual_server_trust_authentication?language=objc

 */

import Foundation

extension NetworkClient: URLSessionDelegate {
	public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
		
		let protectionSpace = challenge.protectionSpace
		guard protectionSpace.host.contains("localhost"), protectionSpace.port == 7111 else {
			completionHandler(.performDefaultHandling, nil)
			return
		}
		
		guard let serverTrust = protectionSpace.serverTrust else {
			completionHandler(.performDefaultHandling, nil)
			return
		}
		
		let credential = URLCredential(trust: serverTrust)
		completionHandler(.useCredential, credential)
	}
}
