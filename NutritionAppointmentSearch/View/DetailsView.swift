//
//  DetailsView.swift
//  NutritionAppointmentSearch
//
//  Created by Gonçalo Almeida on 23/02/2025.
//

import SwiftUI

struct DetailsView: View {
    @StateObject var viewModel: DetailsViewModel
    @State private var showAboutMe = false
    
    init(professionalID: Int) {
        _viewModel = StateObject(wrappedValue: DetailsViewModel(professionalID: professionalID))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIConstants.verticalPadding_16) {
            if let detail = viewModel.professionalDetail {
                HStack {
                    AsyncImage(url: URL(string: detail.profilePictureURL)) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: UIConstants.systemImagePerson)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                    }
                    .frame(width: UIConstants.imageFrame_80, height: UIConstants.imageFrame_80)
                    .clipShape(RoundedRectangle(cornerSize: .zero))
                    
                    VStack(alignment: .leading) {
                        Text(detail.name)
                            .font(.title)
                        Text(detail.formattedRating)
                            .font(.subheadline)
                    }
                }
                
                Text("\(LocalizableKeys.ProfessionalDetail.languagesLabel) \(detail.languages.joined(separator: ", "))")
                    .font(.body)
                Text("\(LocalizableKeys.ProfessionalDetail.expertiseLabel) \(detail.expertise.joined(separator: ", "))")
                    .font(.body)
                
                VStack(alignment: .leading, spacing: UIConstants.verticalPadding_8) {
                    Text(LocalizableKeys.ProfessionalDetail.aboutMe)
                        .font(.headline)
                    
                    if showAboutMe {
                        Text(detail.aboutMe)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .transition(.opacity)
                    }
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showAboutMe.toggle()
                        }
                    }) {
                        Text(showAboutMe ? LocalizableKeys.ProfessionalDetail.showLess : LocalizableKeys.ProfessionalDetail.showMore)
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            } else if viewModel.isLoading {
                Spacer()
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                Spacer()
            } else if viewModel.hasError {
                Spacer()
                Text("\(LocalizableKeys.Generic.error): \(viewModel.errorMessage)")
                    .foregroundColor(.red)
                Spacer()
            }
        }
        .padding()
        .navigationTitle(LocalizableKeys.Navigation.professionalDetailsTitle)
    }
}

#Preview {
    DetailsView(professionalID: 1)
}
