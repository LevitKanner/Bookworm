//
//  EmojiRating .swift
//  Bookworm
//
//  Created by Levit Kanner on 21/11/2019.
//  Copyright © 2019 Levit Kanner. All rights reserved.
//

import SwiftUI

struct EmojiRating_: View {
    let rating: Int16
    
    var body: some View {
        switch rating{
        case 1:
            return Text("🙄")
        case 2:
            return Text("🤨")
        case 3:
            return Text("🧐")
        case 4:
            return Text("🤪")
        default:
            return Text("😍")
        }
    }
}

struct EmojiRating__Previews: PreviewProvider {
    static var previews: some View {
        EmojiRating_(rating: 2)
    }
}
