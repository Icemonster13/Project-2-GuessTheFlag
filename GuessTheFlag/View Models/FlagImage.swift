//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Michael & Diana Pascucci on 6/5/22.
//

import SwiftUI

struct FlagImage: View {
    var image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(image: "US")
            .previewLayout(.sizeThatFits)
    }
}
