//
//  ProfessionalView.swift
//  NutritionAppointmentSearch
//
//  Created by Gonçalo Almeida on 23/02/2025.
//

import SwiftUI

struct ProfessionalView: View {
    let professional: Professional
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: professional.profilePictureURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                } else if phase.error != nil {
                    Image(systemName: UIConstants.systemImagePerson)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                } else {
                    ProgressView()
                }
            }
            .frame(width: UIConstants.imageFrame_60, height: UIConstants.imageFrame_60)
            .clipShape(RoundedRectangle(cornerRadius: .zero))
            
            VStack(alignment: .leading) {
                Text(professional.name)
                    .font(.headline)
                Text(professional.formattedRating)
                    .font(.subheadline)
                Text(professional.languages.joined(separator: ", "))
                    .font(.caption)
                Text(professional.expertise.joined(separator: ", "))
                    .font(.caption)
            }
        }
        .padding(.vertical, UIConstants.verticalPadding_8)
    }
}


#Preview {
    ProfessionalView(professional: Professional(id: 1, name: "Professional", rating: 4, ratingCount: 123, languages: ["PT", "EN"], expertise: ["General Medicine", "Cardiology"], profilePictureURL: "https://thispersondoesnotexist.com"))
}
