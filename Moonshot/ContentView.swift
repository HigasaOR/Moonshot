//
//  ContentView.swift
//  Moonshot
//
//  Created by Chien Lee on 2024/8/2.
//

import SwiftUI

struct missionScrollView: View {
    let columns = [
        GridItem(.adaptive(minimum: 150)),
    ]

    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()

                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                }
                .navigationDestination(for: Mission.self) { mission in
                    MissionView(mission: mission, astronauts: astronauts)
                }
            }
        }
        .padding([.horizontal, .bottom])
    }

    init(missions: [Mission], astronauts: [String: Astronaut]) {
        self.missions = missions
        self.astronauts = astronauts
    }
}

struct missionListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        LazyVStack {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    VStack {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .padding(.leading, 40)
                                .padding(.vertical, 20)

                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding([.horizontal])
                            .frame(maxWidth: .infinity)
                        }
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(.lightBackground)
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                }
                .navigationDestination(for: Mission.self) { mission in
                    MissionView(mission: mission, astronauts: astronauts)
                }
            }
        }
    }

    init(missions: [Mission], astronauts: [String: Astronaut]) {
        self.missions = missions
        self.astronauts = astronauts
    }
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    let columns = [
        GridItem(.adaptive(minimum: 150)),
    ]

    @State private var showingGrid = true

    var body: some View {
        NavigationStack {
            ScrollView {
                if showingGrid {
                    missionScrollView(missions: missions, astronauts: astronauts)
                } else {
                    missionListView(missions: missions, astronauts: astronauts)
                }
            }

            .toolbar {
                Button (showingGrid ? "List View" : "Grid View") {
                    withAnimation {
                        showingGrid.toggle()
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
