import Foundation

final class GameDefaultsManager {
    static let instance = GameDefaultsManager(); private init() {}

    private enum Keys: String {
        case game = "savegame"
    }

    func saveGame(_ game: Game) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(game)
            UserDefaults.standard.setValue(encodedData, forKey: Keys.game.rawValue)
        } catch {
            print(error)
        }
    }

    func loadGame() -> Game? {
        if let savedData = UserDefaults.standard.data(forKey: Keys.game.rawValue) {
            let decoder = JSONDecoder()
            if let loadGame = try? decoder.decode(Game.self, from: savedData) {
                return loadGame
            }
        }
        return nil
    }

    func getNumberOfAttempts() -> Int {
        guard let count = loadGame()?.numberOfAttempts else { return 0 }
        return count
    }

    func getRandomNumber() -> Int {
        Int.random(in: 0 ... 9)
    }

    func removeGame() {
        UserDefaults.standard.removeObject(forKey: Keys.game.rawValue)
    }
}
