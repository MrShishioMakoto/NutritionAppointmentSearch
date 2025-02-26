//
//  ListView.swift
//  NutritionAppointmentSearch
//
//  Created by Gonçalo Almeida on 23/02/2025.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel = ListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Picker(LocalizableKeys.ProfessionalList.sortBy, selection: $viewModel.sortBy) {
                        Text(LocalizableKeys.ProfessionalList.bestMatch).tag("best_match")
                        Text(LocalizableKeys.ProfessionalList.rating).tag("rating")
                        Text(LocalizableKeys.ProfessionalList.mostPopular).tag("most_popular")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: viewModel.sortBy) { oldSort, newSort in
                        viewModel.changeSort(to: newSort)
                    }
                    
                    List {
                        ForEach(viewModel.professionals) { professional in
                            NavigationLink(destination: DetailsView(professionalID: professional.id)) {
                                ProfessionalView(professional: professional)
                            }
                            .onAppear {
                                if professional == viewModel.professionals.last {
                                    Task {
                                        await viewModel.fetchProfessionals()
                                    }
                                }
                            }
                        }
                    }
                    .refreshable {
                        viewModel.refresh()
                    }
                    .listStyle(PlainListStyle())
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle(LocalizableKeys.Navigation.professionalsTitle)
            .navigationBarTitleDisplayMode(.inline)
            .alert(LocalizableKeys.Generic.error, isPresented: $viewModel.hasError) {
                Button(LocalizableKeys.Generic.ok, role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    ListView(viewModel: ListViewModel())
}
