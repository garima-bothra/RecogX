//
//  FAQBotViewController.swift
//  RecogX
//
//  Created by Garima Bothra on 20/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit
import Kommunicate

class FAQBotViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        kommunicateNetworking.shared.registerUser()
//        Kommunicate.createAndShowConversation(from: self) { error in
//            guard error == nil else {
//                print("Conversation error: \(error.debugDescription)")
//                return
//            }
//            // Success
//            debugPrint("SUCCESS")
//        }
//        // Do any additional setup after loading the view.
        let kmConversation = KMConversationBuilder()
//            // Optional. If you do not pass any agent ID, the default agent will
//            // automatically get selected. AGENT_ID is the emailID used to signup
//            // on Kommunicate dashboard.
            .withAgentIds( ["<AGENT_IDS>"])
//            // Optional. A list of botIds. Go to Manage Bots section
//            // (https://dashboard.kommunicate.io/bots/manage-bots) -> Copy botID
            .withBotIds(["clara-4allt"])
//            // If you pass false, then a new conversation will be created every time.
            .useLastConversation(false)
            .build()
//
        Kommunicate.createConversation(conversation: kmConversation) { result in
            switch result {
            case .success(let conversationId):
                print("Conversation id: ",conversationId)
                Kommunicate.showConversationWith(
                    groupId: conversationId,
                    from: self,
                    completionHandler: { success in
                    print("conversation was shown")
                })
            // Launch conversation
            case .failure(let kmConversationError):
                print("Failed to create a conversation: ", kmConversationError)
            }
        }
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
