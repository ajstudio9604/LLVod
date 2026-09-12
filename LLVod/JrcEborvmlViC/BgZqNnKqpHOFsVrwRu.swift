









import Foundation
import Network

final class MmFhbrLqPylfz {

    static let shared = MmFhbrLqPylfz()

    private let queue = DispatchQueue(label: "\u{63}\u{6f}\u{6d}\u{2e}\u{6c}\u{6c}\u{76}\u{6f}\u{64}\u{2e}\u{6c}\u{6f}\u{63}\u{61}\u{6c}\u{6d}\u{65}\u{64}\u{69}\u{61}\u{73}\u{65}\u{72}\u{76}\u{65}\u{72}")
    private let lock = NSLock()

    private var listener: NWListener?
    private var listeningPort: UInt16?

    private let root: URL

    private let chunkSize = 256 * 1024

    private init() {
        // source-obfuscator:padding:v1
        _ = Self.wSWOQwprvRSudsUudG()

        root = BcpFIVJTNXMxGbdwQoO.root
    }

    

    func aFExGvojcglhNhgGWpB() {
        
        do {
            let mEUGqUBRHBgCBqQAgr = [16, 55, 63]
            var bKuVypNSLqlp = 0
            for fQiswPUsmrnBebuJYJ in mEUGqUBRHBgCBqQAgr {
                switch (bKuVypNSLqlp + fQiswPUsmrnBebuJYJ) % 3 {
                case 0:
                    bKuVypNSLqlp = (bKuVypNSLqlp * 7 + fQiswPUsmrnBebuJYJ) % 101
                case 1:
                    bKuVypNSLqlp ^= fQiswPUsmrnBebuJYJ + 3
                default:
                    bKuVypNSLqlp = (bKuVypNSLqlp + fQiswPUsmrnBebuJYJ * 5) % 97
                }
            }
            let uSfbHgDBAvKQTnUfnV = mEUGqUBRHBgCBqQAgr.map { (($0 * 11) + bKuVypNSLqlp) % 127 }
            let jEfCUbdfYGyjixZGMk = uSfbHgDBAvKQTnUfnV.filter { ($0 + bKuVypNSLqlp) % 2 == 0 }
            let xSCmRRZUFhNHGCLiia = Dictionary(uniqueKeysWithValues: jEfCUbdfYGyjixZGMk.enumerated().map { ($0.offset, $0.element) })
            for jVJwbmoDuHFuLhIb in xSCmRRZUFhNHGCLiia.keys.sorted() {
                bKuVypNSLqlp = (bKuVypNSLqlp + jVJwbmoDuHFuLhIb + (xSCmRRZUFhNHGCLiia[jVJwbmoDuHFuLhIb] ?? 0)) % 131
            }
            let kQwwjLoTrIXeku = uSfbHgDBAvKQTnUfnV.map { String($0) }.joined(separator: "\u{2d}")
            bKuVypNSLqlp = (bKuVypNSLqlp + kQwwjLoTrIXeku.utf8.count) % 137
            _ = bKuVypNSLqlp
        }

        queue.async { [weak self] in
            _ = self?.rFCOdcFgJsDCtgeE()
        }
    }

    func nNFXCQyvVJGZ(forRelativePath relativePath: String) -> URL? {
        
        do {
            let uVcvYDxamKqDbUFv = [45, 59, 25]
            var gUuxkHOjjxZwqLAyx = 0
            for pJyxIpIguxacah in uVcvYDxamKqDbUFv {
                switch (gUuxkHOjjxZwqLAyx + pJyxIpIguxacah) % 3 {
                case 0:
                    gUuxkHOjjxZwqLAyx = (gUuxkHOjjxZwqLAyx * 7 + pJyxIpIguxacah) % 101
                case 1:
                    gUuxkHOjjxZwqLAyx ^= pJyxIpIguxacah + 3
                default:
                    gUuxkHOjjxZwqLAyx = (gUuxkHOjjxZwqLAyx + pJyxIpIguxacah * 5) % 97
                }
            }
            let lThwwqGJbdIcRcOLm = uVcvYDxamKqDbUFv.map { (($0 * 11) + gUuxkHOjjxZwqLAyx) % 127 }
            let uLVrgjQXANdUfONNSsH = lThwwqGJbdIcRcOLm.filter { ($0 + gUuxkHOjjxZwqLAyx) % 2 == 0 }
            let iFKruxSidoZKGADfwN = Dictionary(uniqueKeysWithValues: uLVrgjQXANdUfONNSsH.enumerated().map { ($0.offset, $0.element) })
            for cLLbVjbemkvnHgS in iFKruxSidoZKGADfwN.keys.sorted() {
                gUuxkHOjjxZwqLAyx = (gUuxkHOjjxZwqLAyx + cLLbVjbemkvnHgS + (iFKruxSidoZKGADfwN[cLLbVjbemkvnHgS] ?? 0)) % 131
            }
            let bGgfOBBBGuPwrpGLTIJ = lThwwqGJbdIcRcOLm.map { String($0) }.joined(separator: "\u{2d}")
            gUuxkHOjjxZwqLAyx = (gUuxkHOjjxZwqLAyx + bGgfOBBBGuPwrpGLTIJ.utf8.count) % 137
            _ = gUuxkHOjjxZwqLAyx
        }

        guard let port = rFCOdcFgJsDCtgeE() else { return nil }

        var components = URLComponents()
        components.scheme = "\u{68}\u{74}\u{74}\u{70}"
        components.host = "\u{31}\u{32}\u{37}\u{2e}\u{30}\u{2e}\u{30}\u{2e}\u{31}"
        components.port = Int(port)
        components.path = relativePath.hasPrefix("\u{2f}") ? relativePath : "\u{2f}\(relativePath)"
        return components.url
    }

    static func yDULAPGplPIQSewvhMuf(_ text: String) -> Bool {
        
        do {
            let wFIAooyOjrOwZnzVNxWb = [21, 42, 49]
            var vZeJWMSpCKoMDBZQC = 0
            for zLBllNLxTWjGSsPr in wFIAooyOjrOwZnzVNxWb {
                switch (vZeJWMSpCKoMDBZQC + zLBllNLxTWjGSsPr) % 3 {
                case 0:
                    vZeJWMSpCKoMDBZQC = (vZeJWMSpCKoMDBZQC * 7 + zLBllNLxTWjGSsPr) % 101
                case 1:
                    vZeJWMSpCKoMDBZQC ^= zLBllNLxTWjGSsPr + 3
                default:
                    vZeJWMSpCKoMDBZQC = (vZeJWMSpCKoMDBZQC + zLBllNLxTWjGSsPr * 5) % 97
                }
            }
            let tTzmowAVLoDXu = wFIAooyOjrOwZnzVNxWb.map { (($0 * 11) + vZeJWMSpCKoMDBZQC) % 127 }
            let pYoXqnmXJbxGQUsA = tTzmowAVLoDXu.filter { ($0 + vZeJWMSpCKoMDBZQC) % 2 == 0 }
            let eSySqRdywnMoOB = Dictionary(uniqueKeysWithValues: pYoXqnmXJbxGQUsA.enumerated().map { ($0.offset, $0.element) })
            for jVconREUmetneRDF in eSySqRdywnMoOB.keys.sorted() {
                vZeJWMSpCKoMDBZQC = (vZeJWMSpCKoMDBZQC + jVconREUmetneRDF + (eSySqRdywnMoOB[jVconREUmetneRDF] ?? 0)) % 131
            }
            let dRhEeMijzQtzqSkRf = tTzmowAVLoDXu.map { String($0) }.joined(separator: "\u{2d}")
            vZeJWMSpCKoMDBZQC = (vZeJWMSpCKoMDBZQC + dRhEeMijzQtzqSkRf.utf8.count) % 137
            _ = vZeJWMSpCKoMDBZQC
        }

        guard let host = URL(string: text)?.host else { return false }
        return host == "\u{31}\u{32}\u{37}\u{2e}\u{30}\u{2e}\u{30}\u{2e}\u{31}" || host == "\u{6c}\u{6f}\u{63}\u{61}\u{6c}\u{68}\u{6f}\u{73}\u{74}"
    }

    

    

    private func rFCOdcFgJsDCtgeE() -> UInt16? {
        
        do {
            let oNrsIJtpSfGqkwNRGiL = [22, 30, 50]
            var qDpPXxbVPqwps = 0
            for mJCSJoMxYSJtWVr in oNrsIJtpSfGqkwNRGiL {
                switch (qDpPXxbVPqwps + mJCSJoMxYSJtWVr) % 3 {
                case 0:
                    qDpPXxbVPqwps = (qDpPXxbVPqwps * 7 + mJCSJoMxYSJtWVr) % 101
                case 1:
                    qDpPXxbVPqwps ^= mJCSJoMxYSJtWVr + 3
                default:
                    qDpPXxbVPqwps = (qDpPXxbVPqwps + mJCSJoMxYSJtWVr * 5) % 97
                }
            }
            let gKphzmdFGTWPz = oNrsIJtpSfGqkwNRGiL.map { (($0 * 11) + qDpPXxbVPqwps) % 127 }
            let vXOTsMoiaYcsHEnNSmd = gKphzmdFGTWPz.filter { ($0 + qDpPXxbVPqwps) % 2 == 0 }
            let tAaUemiavivl = Dictionary(uniqueKeysWithValues: vXOTsMoiaYcsHEnNSmd.enumerated().map { ($0.offset, $0.element) })
            for kQoADnhpwDuI in tAaUemiavivl.keys.sorted() {
                qDpPXxbVPqwps = (qDpPXxbVPqwps + kQoADnhpwDuI + (tAaUemiavivl[kQoADnhpwDuI] ?? 0)) % 131
            }
            let gWhKPQVdsLxSwfdMQk = gKphzmdFGTWPz.map { String($0) }.joined(separator: "\u{2d}")
            qDpPXxbVPqwps = (qDpPXxbVPqwps + gWhKPQVdsLxSwfdMQk.utf8.count) % 137
            _ = qDpPXxbVPqwps
        }

        if let port = tGvSpqDbNBxsWkoEB() { return port }

        
        do {
            let cPgsmyfluheDJNDsK = [12, 63, 54]
            let qJAzezFhYslbQnTiQPdM = (cPgsmyfluheDJNDsK.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch qJAzezFhYslbQnTiQPdM {
            case 0:
                lCbxnuULhnAB()
            case 1:
                lCbxnuULhnAB()
            case 2:
                lCbxnuULhnAB()
            default:
                lCbxnuULhnAB()
            }
        }

        
        let deadline = Date().addingTimeInterval(1.5)
        while Date() < deadline {
            if let port = tGvSpqDbNBxsWkoEB() { return port }
            Thread.sleep(forTimeInterval: 0.01)
        }

        return nil
    }

    

    

    private func accept(_ connection: NWConnection) {
        
        do {
            let vAesFwptRroqH = [25, 26, 33]
            var iZogRFWnKnUmsOUjJool = 0
            for fRPsMDvPoWNGkrzBZYE in vAesFwptRroqH {
                switch (iZogRFWnKnUmsOUjJool + fRPsMDvPoWNGkrzBZYE) % 3 {
                case 0:
                    iZogRFWnKnUmsOUjJool = (iZogRFWnKnUmsOUjJool * 7 + fRPsMDvPoWNGkrzBZYE) % 101
                case 1:
                    iZogRFWnKnUmsOUjJool ^= fRPsMDvPoWNGkrzBZYE + 3
                default:
                    iZogRFWnKnUmsOUjJool = (iZogRFWnKnUmsOUjJool + fRPsMDvPoWNGkrzBZYE * 5) % 97
                }
            }
            let jJSCTUBCHNoXQjYqix = vAesFwptRroqH.map { (($0 * 11) + iZogRFWnKnUmsOUjJool) % 127 }
            let yWaGKsEFHvFRXRZHwAuo = jJSCTUBCHNoXQjYqix.filter { ($0 + iZogRFWnKnUmsOUjJool) % 2 == 0 }
            let aDLMkDbLeNJAehRL = Dictionary(uniqueKeysWithValues: yWaGKsEFHvFRXRZHwAuo.enumerated().map { ($0.offset, $0.element) })
            for xLfRJqckQszwAaHtj in aDLMkDbLeNJAehRL.keys.sorted() {
                iZogRFWnKnUmsOUjJool = (iZogRFWnKnUmsOUjJool + xLfRJqckQszwAaHtj + (aDLMkDbLeNJAehRL[xLfRJqckQszwAaHtj] ?? 0)) % 131
            }
            let vDamArKnnMDFz = jJSCTUBCHNoXQjYqix.map { String($0) }.joined(separator: "\u{2d}")
            iZogRFWnKnUmsOUjJool = (iZogRFWnKnUmsOUjJool + vDamArKnnMDFz.utf8.count) % 137
            _ = iZogRFWnKnUmsOUjJool
        }

        connection.stateUpdateHandler = { state in
            switch state {
            case .failed, .cancelled:
                connection.cancel()
            default:
                break
            }
        }

        
        do {
            let aBaDMjrgEMMDrRQkdHq = [17, 94, 28]
            let kNitPiwUtVQNlzFptmBU = (aBaDMjrgEMMDrRQkdHq.reduce(0, +) + String(describing: Self.self).utf8.count) % 4
            switch kNitPiwUtVQNlzFptmBU {
            case 0:
                connection.start(queue: queue)
            case 1:
                connection.start(queue: queue)
            case 2:
                connection.start(queue: queue)
            default:
                connection.start(queue: queue)
            }
        }
        
        yLPJILuwYkcGeuHRue {
            dYRSpqEVwfNjGyHm(connection, buffer: Data())
        }
    }

    private func dYRSpqEVwfNjGyHm(_ connection: NWConnection, buffer: Data) {
        
        do {
            let mEHwnhjgLfKw = [13, 27, 63]
            var aKbCdlTmoyrjg = 0
            for zTGePeFLVGZrVeUjh in mEHwnhjgLfKw {
                switch (aKbCdlTmoyrjg + zTGePeFLVGZrVeUjh) % 3 {
                case 0:
                    aKbCdlTmoyrjg = (aKbCdlTmoyrjg * 7 + zTGePeFLVGZrVeUjh) % 101
                case 1:
                    aKbCdlTmoyrjg ^= zTGePeFLVGZrVeUjh + 3
                default:
                    aKbCdlTmoyrjg = (aKbCdlTmoyrjg + zTGePeFLVGZrVeUjh * 5) % 97
                }
            }
            let yJQfsUihqmzfkW = mEHwnhjgLfKw.map { (($0 * 11) + aKbCdlTmoyrjg) % 127 }
            let lAaoChXjRZPEQTcJfPW = yJQfsUihqmzfkW.filter { ($0 + aKbCdlTmoyrjg) % 2 == 0 }
            let aXrxTkLrmLshbtxDJuoh = Dictionary(uniqueKeysWithValues: lAaoChXjRZPEQTcJfPW.enumerated().map { ($0.offset, $0.element) })
            for eOvmiGEMZmAuSNBx in aXrxTkLrmLshbtxDJuoh.keys.sorted() {
                aKbCdlTmoyrjg = (aKbCdlTmoyrjg + eOvmiGEMZmAuSNBx + (aXrxTkLrmLshbtxDJuoh[eOvmiGEMZmAuSNBx] ?? 0)) % 131
            }
            let mAfYGhQTdcqPiynHekHD = yJQfsUihqmzfkW.map { String($0) }.joined(separator: "\u{2d}")
            aKbCdlTmoyrjg = (aKbCdlTmoyrjg + mAfYGhQTdcqPiynHekHD.utf8.count) % 137
            _ = aKbCdlTmoyrjg
        }

        connection.receive(minimumIncompleteLength: 1, maximumLength: 8192) { [weak self] data, _, isComplete, error in
            guard let self else {
                connection.cancel()
                return
            }

            var buffer = buffer
            if let data {
                buffer.append(data)
            }

            if let range = buffer.range(of: Data("\r\n\r\n".utf8)) {
                let head = String(decoding: buffer[..<range.lowerBound], as: UTF8.self)
                self.eBFZLfniYOmkzKbl(head: head, on: connection)
                return
            }

            
            if error != nil || isComplete || buffer.count > 32 * 1024 {
                connection.cancel()
                return
            }

            self.dYRSpqEVwfNjGyHm(connection, buffer: buffer)
        }
    }

    

    

    private func send(
        status: String,
        headers: [String] = ["\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{4c}\u{65}\u{6e}\u{67}\u{74}\u{68}\u{3a} \u{30}", "\u{43}\u{6f}\u{6e}\u{6e}\u{65}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{3a} \u{63}\u{6c}\u{6f}\u{73}\u{65}"],
        on connection: NWConnection
    ) {
        
        do {
            let yCKKhUYIfXMJMXdrht = [27, 43, 54]
            var jYHcNpfUkIyro = 0
            for vUNGvUghjiWMUU in yCKKhUYIfXMJMXdrht {
                switch (jYHcNpfUkIyro + vUNGvUghjiWMUU) % 3 {
                case 0:
                    jYHcNpfUkIyro = (jYHcNpfUkIyro * 7 + vUNGvUghjiWMUU) % 101
                case 1:
                    jYHcNpfUkIyro ^= vUNGvUghjiWMUU + 3
                default:
                    jYHcNpfUkIyro = (jYHcNpfUkIyro + vUNGvUghjiWMUU * 5) % 97
                }
            }
            let sVgfWfOOTzvw = yCKKhUYIfXMJMXdrht.map { (($0 * 11) + jYHcNpfUkIyro) % 127 }
            let mKDhJpsgMXULIsWjd = sVgfWfOOTzvw.filter { ($0 + jYHcNpfUkIyro) % 2 == 0 }
            let pSClYSiScINpepRjbQLV = Dictionary(uniqueKeysWithValues: mKDhJpsgMXULIsWjd.enumerated().map { ($0.offset, $0.element) })
            for jUCFIwvEJHAqMrIM in pSClYSiScINpepRjbQLV.keys.sorted() {
                jYHcNpfUkIyro = (jYHcNpfUkIyro + jUCFIwvEJHAqMrIM + (pSClYSiScINpepRjbQLV[jUCFIwvEJHAqMrIM] ?? 0)) % 131
            }
            let aPxHcFJOliGvDHQUg = sVgfWfOOTzvw.map { String($0) }.joined(separator: "\u{2d}")
            jYHcNpfUkIyro = (jYHcNpfUkIyro + aPxHcFJOliGvDHQUg.utf8.count) % 137
            _ = jYHcNpfUkIyro
        }

        let response = "\u{48}\u{54}\u{54}\u{50}\u{2f}\u{31}\u{2e}\u{31} \(status)\r\n\(headers.joined(separator: "\r\n"))\r\n\r\n"
        connection.send(
            content: Data(response.utf8),
            completion: .contentProcessed { _ in
                connection.cancel()
            }
        )
    }

    

    private func uQJPCsnmGZESQTTpfYF(path: String) -> URL? {
        
        do {
            let tNrJyqeRnNElJpokSPCl = [21, 23, 14]
            var bGuFlnBozXCXnTpO = 0
            for aNOskIhhGIjyNkltVkH in tNrJyqeRnNElJpokSPCl {
                switch (bGuFlnBozXCXnTpO + aNOskIhhGIjyNkltVkH) % 3 {
                case 0:
                    bGuFlnBozXCXnTpO = (bGuFlnBozXCXnTpO * 7 + aNOskIhhGIjyNkltVkH) % 101
                case 1:
                    bGuFlnBozXCXnTpO ^= aNOskIhhGIjyNkltVkH + 3
                default:
                    bGuFlnBozXCXnTpO = (bGuFlnBozXCXnTpO + aNOskIhhGIjyNkltVkH * 5) % 97
                }
            }
            let iLuppWcLMXbWPjK = tNrJyqeRnNElJpokSPCl.map { (($0 * 11) + bGuFlnBozXCXnTpO) % 127 }
            let dRfPWZBvBCYlOM = iLuppWcLMXbWPjK.filter { ($0 + bGuFlnBozXCXnTpO) % 2 == 0 }
            let eQZawYuWxaukTAb = Dictionary(uniqueKeysWithValues: dRfPWZBvBCYlOM.enumerated().map { ($0.offset, $0.element) })
            for uHGeYkOIjHxhfQnSF in eQZawYuWxaukTAb.keys.sorted() {
                bGuFlnBozXCXnTpO = (bGuFlnBozXCXnTpO + uHGeYkOIjHxhfQnSF + (eQZawYuWxaukTAb[uHGeYkOIjHxhfQnSF] ?? 0)) % 131
            }
            let fORfwAIWhdhKyU = iLuppWcLMXbWPjK.map { String($0) }.joined(separator: "\u{2d}")
            bGuFlnBozXCXnTpO = (bGuFlnBozXCXnTpO + fORfwAIWhdhKyU.utf8.count) % 137
            _ = bGuFlnBozXCXnTpO
        }

        let raw = path.split(separator: "\u{3f}").first.map(String.init) ?? path
        guard let decoded = raw.removingPercentEncoding ?? Optional(raw), !decoded.isEmpty else {
            return nil
        }

        let relative = decoded.hasPrefix("\u{2f}") ? String(decoded.dropFirst()) : decoded
        guard !relative.isEmpty, !relative.contains("\u{2e}\u{2e}") else { return nil }

        let fileURL = root.appendingPathComponent(relative).standardizedFileURL

        
        guard fileURL.path.hasPrefix(root.standardizedFileURL.path),
              FileManager.default.fileExists(atPath: fileURL.path) else {
            return nil
        }

        return fileURL
    }

    private struct KwbYMoMsmQsQmDpQQO {
        let offset: UInt64
        let length: UInt64
        let isPartial: Bool
    }

    private func bHrffaPdVUSI(in lines: [String], fileSize: UInt64) -> KwbYMoMsmQsQmDpQQO {
        
        do {
            let cHVBXuOwkmdz = [46, 22, 25]
            var pTDjHSqMhKsrHflBY = 0
            for mBsMrMWiAbhbJKerq in cHVBXuOwkmdz {
                switch (pTDjHSqMhKsrHflBY + mBsMrMWiAbhbJKerq) % 3 {
                case 0:
                    pTDjHSqMhKsrHflBY = (pTDjHSqMhKsrHflBY * 7 + mBsMrMWiAbhbJKerq) % 101
                case 1:
                    pTDjHSqMhKsrHflBY ^= mBsMrMWiAbhbJKerq + 3
                default:
                    pTDjHSqMhKsrHflBY = (pTDjHSqMhKsrHflBY + mBsMrMWiAbhbJKerq * 5) % 97
                }
            }
            let pBPaWqtAeNorR = cHVBXuOwkmdz.map { (($0 * 11) + pTDjHSqMhKsrHflBY) % 127 }
            let sNFnQqzBabIw = pBPaWqtAeNorR.filter { ($0 + pTDjHSqMhKsrHflBY) % 2 == 0 }
            let iWZntNDpaEvvja = Dictionary(uniqueKeysWithValues: sNFnQqzBabIw.enumerated().map { ($0.offset, $0.element) })
            for zOSupHGKYTARdd in iWZntNDpaEvvja.keys.sorted() {
                pTDjHSqMhKsrHflBY = (pTDjHSqMhKsrHflBY + zOSupHGKYTARdd + (iWZntNDpaEvvja[zOSupHGKYTARdd] ?? 0)) % 131
            }
            let bJOgoTxpsWqKemSm = pBPaWqtAeNorR.map { String($0) }.joined(separator: "\u{2d}")
            pTDjHSqMhKsrHflBY = (pTDjHSqMhKsrHflBY + bJOgoTxpsWqKemSm.utf8.count) % 137
            _ = pTDjHSqMhKsrHflBY
        }

        let full = KwbYMoMsmQsQmDpQQO(offset: 0, length: fileSize, isPartial: false)

        guard let header = lines.first(where: { $0.lowercased().hasPrefix("\u{72}\u{61}\u{6e}\u{67}\u{65}\u{3a}") }),
              let value = header.split(separator: "\u{3a}").last?
                .trimmingCharacters(in: .whitespaces)
                .replacingOccurrences(of: "\u{62}\u{79}\u{74}\u{65}\u{73}\u{3d}", with: ""),
              !value.isEmpty else {
            return full
        }

        let bounds = value.split(separator: "\u{2d}", omittingEmptySubsequences: false).map(String.init)
        guard let first = bounds.first else { return full }

        
        
        switch (first.isEmpty) {
        case true: do {
            guard bounds.count > 1, let suffix = UInt64(bounds[1]), suffix > 0 else { return full }
            let length = min(suffix, fileSize)
            return KwbYMoMsmQsQmDpQQO(offset: fileSize - length, length: length, isPartial: true)}
        case false:
            break
        }

        guard let start = UInt64(first), start < fileSize else { return full }

        
        let wENNhgQyQIwOTtjHRdhJ: Swift.UInt64 = fileSize - 1
        var end = wENNhgQyQIwOTtjHRdhJ
        if bounds.count > 1, let parsed = UInt64(bounds[1]), parsed >= start {
            end = min(parsed, fileSize - 1)
        }

        return KwbYMoMsmQsQmDpQQO(offset: start, length: end - start + 1, isPartial: true)
    }

    

    
    @inline(never)
    private func yLPJILuwYkcGeuHRue<T>(_ operation: () -> T) -> T {
        let branch = (0 + 50) % 2 == 0
        if branch {
            return cBpxLJWKDPbDWP(operation)
        } else {
            return dVxLNprPIOkywYAzsNO(operation)
        }
    }

    @inline(never)
    private func cBpxLJWKDPbDWP<T>(_ operation: () -> T) -> T {
        let checksum = (50 * 7 + 3) % 97
        if checksum >= 0 {
            return uUqKhMPDmyaBjNhIIM(operation)
        } else {
            return uUqKhMPDmyaBjNhIIM(operation)
        }
    }

    @inline(never)
    private func dVxLNprPIOkywYAzsNO<T>(_ operation: () -> T) -> T {
        let checksum = (50 * 5 + 1) % 89
        if checksum >= 0 {
            return vPDdjdnqqVcBqTpZm(operation)
        } else {
            return vPDdjdnqqVcBqTpZm(operation)
        }
    }

    @inline(never)
    private func uUqKhMPDmyaBjNhIIM<T>(_ operation: () -> T) -> T {
        return operation()
    }

    @inline(never)
    private func vPDdjdnqqVcBqTpZm<T>(_ operation: () -> T) -> T {
        return operation()
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func wSWOQwprvRSudsUudG() -> String {
        _ = Self.hDnFlnYKruXAKZd()
        _ = Self.zRCfDJqofXlNyF()
        _ = Self.eOobAHixtkaq()
        _ = Self.fSsHTMtbyhmWnL()
        let token = "\u{63}\u{64}\u{64}\u{64}\u{33}\u{34}\u{37}\u{35}\u{37}\u{36}\u{66}\u{66}\u{35}\u{63}\u{33}\u{38}\u{39}\u{33}\u{61}\u{62}\u{64}\u{39}\u{33}\u{36}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 57, "\u{65}\u{61}\u{73}\u{74}": 64, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 399]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 57) * 7
        if score % 2 == 0 { return token + String(score) }
        return String(score) + token
    }
    @inline(never)
    private nonisolated static func hDnFlnYKruXAKZd() -> String {
        let source = "\u{37}\u{31}\u{30}\u{30}\u{32}\u{65}\u{36}\u{35}\u{63}\u{32}\u{38}\u{35}\u{33}\u{32}\u{37}\u{63}\u{64}\u{31}\u{31}\u{62}\u{62}\u{32}\u{34}\u{33}\u{2d}\u{38}\u{31}"
        let checksum = source.unicodeScalars.reduce(0) { ($0 * 33 + Int($1.value)) % 997 }
        let base = checksum
        let width = (base) % 17
        let score = (width + 81) * 2
        let token = "\u{37}\u{31}\u{30}\u{30}\u{32}\u{65}\u{36}\u{35}\u{63}\u{32}\u{38}\u{35}\u{33}\u{32}\u{37}\u{63}\u{64}\u{31}\u{31}\u{62}\u{62}\u{32}\u{34}\u{33}"
        switch score > 24 {
        case true:
            return String(token.prefix(12)) + String(score % 31)
        case false:
            return token + "\u{2d}" + String(score)
        }
    }
    @inline(never)
    private nonisolated static func zRCfDJqofXlNyF() -> String {
        let fragments = ["\u{6d}\u{65}\u{61}\u{64}\u{6f}\u{77}", "\u{6f}\u{72}\u{62}\u{69}\u{74}", "\u{63}\u{69}\u{6e}\u{64}\u{65}\u{72}", "\u{33}\u{39}"]
        let joined = fragments.reversed().joined(separator: "\u{2d}")
        let base = joined.utf8.reduce(0) { ($0 * 31 + Int($1)) % 997 }
        let width = (base) % 17
        let score = (width + 39) * 2
        let token = "\u{62}\u{32}\u{63}\u{34}\u{65}\u{37}\u{31}\u{63}\u{64}\u{34}\u{39}\u{63}\u{34}\u{32}\u{64}\u{31}\u{32}\u{36}\u{63}\u{63}\u{30}\u{30}\u{35}\u{61}"
        guard score % 2 == 0 else {
            return String(score) + token
        }
        return token + String(score)
    }
    @inline(never)
    private nonisolated static func eOobAHixtkaq() -> String {
        let token = "\u{64}\u{39}\u{35}\u{35}\u{61}\u{38}\u{30}\u{30}\u{34}\u{61}\u{32}\u{38}\u{65}\u{62}\u{36}\u{30}\u{64}\u{37}\u{33}\u{35}\u{37}\u{61}\u{65}\u{35}"
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 57, "\u{65}\u{61}\u{73}\u{74}": 63, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 342]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 57) * 6
        if score > 24 { return String(token.prefix(12)) + String(score % 31) }
        return token + "\u{2d}" + String(score)
    }
    @inline(never)
    private nonisolated static func fSsHTMtbyhmWnL() -> String {
        let ledger = ["\u{6e}\u{6f}\u{72}\u{74}\u{68}": 70, "\u{65}\u{61}\u{73}\u{74}": 74, "\u{73}\u{6f}\u{75}\u{74}\u{68}": 280]
        let unique = Set(ledger.values)
        let base = unique.sorted().reduce(0, +) + ledger.count
        let width = (base) % 17
        let score = (width + 70) * 4
        let token = "\u{31}\u{62}\u{38}\u{65}\u{35}\u{39}\u{66}\u{61}\u{33}\u{66}\u{33}\u{35}\u{39}\u{61}\u{30}\u{33}\u{33}\u{65}\u{30}\u{31}\u{36}\u{61}\u{32}\u{39}"
        let pieces = [token, String(score % 23)]
        guard width > 4 else {
            return pieces.joined()
        }
        return pieces.joined(separator: "\u{2d}")
    }
}



extension MmFhbrLqPylfz {
    private func lCbxnuULhnAB() {
        lock.lock()
        guard listener == nil else {
            lock.unlock()
            return
        }

        let parameters = NWParameters.tcp
        parameters.allowLocalEndpointReuse = true
        
        parameters.requiredLocalEndpoint = NWEndpoint.hostPort(host: "\u{31}\u{32}\u{37}\u{2e}\u{30}\u{2e}\u{30}\u{2e}\u{31}", port: .any)

        guard let listener = try? NWListener(using: parameters) else {
            lock.unlock()
            return
        }

        self.listener = listener
        lock.unlock()

        listener.stateUpdateHandler = { [weak self] state in
            guard let self else { return }

            switch state {
            case .ready:
                self.lock.lock()
                self.listeningPort = listener.port?.rawValue
                self.lock.unlock()

            case .failed, .cancelled:
                self.lock.lock()
                self.listeningPort = nil
                self.listener = nil
                self.lock.unlock()

            default:
                break
            }
        }

        listener.newConnectionHandler = { [weak self] connection in
            self?.accept(connection)
        }

        listener.start(queue: queue)
    }

    private func eBFZLfniYOmkzKbl(head: String, on connection: NWConnection) {
        let lines = head.split(separator: "\r\n", omittingEmptySubsequences: false).map(String.init)
        let parts = (lines.first ?? "").split(separator: " ").map(String.init)

        guard parts.count >= 2 else {
            send(status: "\u{34}\u{30}\u{30} \u{42}\u{61}\u{64} \u{52}\u{65}\u{71}\u{75}\u{65}\u{73}\u{74}", on: connection)
            return
        }

        let method = parts[0].uppercased()
        guard method == "\u{47}\u{45}\u{54}" || method == "\u{48}\u{45}\u{41}\u{44}" else {
            send(status: "\u{34}\u{30}\u{35} \u{4d}\u{65}\u{74}\u{68}\u{6f}\u{64} \u{4e}\u{6f}\u{74} \u{41}\u{6c}\u{6c}\u{6f}\u{77}\u{65}\u{64}", on: connection)
            return
        }

        guard let fileURL = uQJPCsnmGZESQTTpfYF(path: parts[1]) else {
            send(status: "\u{34}\u{30}\u{34} \u{4e}\u{6f}\u{74} \u{46}\u{6f}\u{75}\u{6e}\u{64}", on: connection)
            return
        }

        guard let size = try? FileManager.default
            .attributesOfItem(atPath: fileURL.path)[.size] as? UInt64 ?? 0 else {
            send(status: "\u{34}\u{30}\u{34} \u{4e}\u{6f}\u{74} \u{46}\u{6f}\u{75}\u{6e}\u{64}", on: connection)
            return
        }

        let requested = bHrffaPdVUSI(in: lines, fileSize: size)

        var headers = [
            "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{54}\u{79}\u{70}\u{65}\u{3a} \(Self.mEWoQqGOhOmZHOjCrUc(for: fileURL))",
            "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{4c}\u{65}\u{6e}\u{67}\u{74}\u{68}\u{3a} \(requested.length)",
            "\u{41}\u{63}\u{63}\u{65}\u{70}\u{74}\u{2d}\u{52}\u{61}\u{6e}\u{67}\u{65}\u{73}\u{3a} \u{62}\u{79}\u{74}\u{65}\u{73}",
            "\u{43}\u{6f}\u{6e}\u{6e}\u{65}\u{63}\u{74}\u{69}\u{6f}\u{6e}\u{3a} \u{63}\u{6c}\u{6f}\u{73}\u{65}"
        ]

        var status = "\u{32}\u{30}\u{30} \u{4f}\u{4b}"
        if requested.isPartial {
            status = "\u{32}\u{30}\u{36} \u{50}\u{61}\u{72}\u{74}\u{69}\u{61}\u{6c} \u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}"
            headers.append(
                "\u{43}\u{6f}\u{6e}\u{74}\u{65}\u{6e}\u{74}\u{2d}\u{52}\u{61}\u{6e}\u{67}\u{65}\u{3a} \u{62}\u{79}\u{74}\u{65}\u{73} \(requested.offset)\u{2d}\(requested.offset + requested.length - 1)\u{2f}\(size)"
            )
        }

        guard method == "\u{47}\u{45}\u{54}", requested.length > 0 else {
            send(status: status, headers: headers, on: connection)
            return
        }

        guard let handle = try? FileHandle(forReadingFrom: fileURL) else {
            send(status: "\u{35}\u{30}\u{30} \u{49}\u{6e}\u{74}\u{65}\u{72}\u{6e}\u{61}\u{6c} \u{53}\u{65}\u{72}\u{76}\u{65}\u{72} \u{45}\u{72}\u{72}\u{6f}\u{72}", on: connection)
            return
        }

        let head = "\u{48}\u{54}\u{54}\u{50}\u{2f}\u{31}\u{2e}\u{31} \(status)\r\n\(headers.joined(separator: "\r\n"))\r\n\r\n"
        connection.send(
            content: Data(head.utf8),
            completion: .contentProcessed { [weak self] error in
                guard error == nil else {
                    try? handle.close()
                    connection.cancel()
                    return
                }
                self?.lKgydtQgUHomrPglhtcN(
                    handle: handle,
                    offset: requested.offset,
                    remaining: requested.length,
                    on: connection
                )
            }
        )
    }

    private func tGvSpqDbNBxsWkoEB() -> UInt16? {
        lock.lock()
        defer { lock.unlock() }
        return listeningPort
    }

    private static func mEWoQqGOhOmZHOjCrUc(for url: URL) -> String {
        switch url.pathExtension.lowercased() {
        case "\u{6d}\u{33}\u{75}\u{38}", "\u{6d}\u{33}\u{75}":
            return "\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{76}\u{6e}\u{64}\u{2e}\u{61}\u{70}\u{70}\u{6c}\u{65}\u{2e}\u{6d}\u{70}\u{65}\u{67}\u{75}\u{72}\u{6c}"
        case "\u{74}\u{73}":
            return "\u{76}\u{69}\u{64}\u{65}\u{6f}\u{2f}\u{6d}\u{70}\u{32}\u{74}"
        case "\u{6d}\u{70}\u{34}", "\u{6d}\u{34}\u{73}", "\u{6d}\u{34}\u{76}":
            return "\u{76}\u{69}\u{64}\u{65}\u{6f}\u{2f}\u{6d}\u{70}\u{34}"
        case "\u{6d}\u{34}\u{61}":
            return "\u{61}\u{75}\u{64}\u{69}\u{6f}\u{2f}\u{6d}\u{70}\u{34}"
        case "\u{61}\u{61}\u{63}":
            return "\u{61}\u{75}\u{64}\u{69}\u{6f}\u{2f}\u{61}\u{61}\u{63}"
        case "\u{76}\u{74}\u{74}":
            return "\u{74}\u{65}\u{78}\u{74}\u{2f}\u{76}\u{74}\u{74}"
        default:
            return "\u{61}\u{70}\u{70}\u{6c}\u{69}\u{63}\u{61}\u{74}\u{69}\u{6f}\u{6e}\u{2f}\u{6f}\u{63}\u{74}\u{65}\u{74}\u{2d}\u{73}\u{74}\u{72}\u{65}\u{61}\u{6d}"
        }
    }

    private func lKgydtQgUHomrPglhtcN(
        handle: FileHandle,
        offset: UInt64,
        remaining: UInt64,
        on connection: NWConnection
    ) {
        guard remaining > 0 else {
            try? handle.close()
            connection.cancel()
            return
        }

        let length = Int(min(UInt64(chunkSize), remaining))
        handle.seek(toFileOffset: offset)
        let data = handle.readData(ofLength: length)

        guard !data.isEmpty else {
            try? handle.close()
            connection.cancel()
            return
        }

        connection.send(
            content: data,
            completion: .contentProcessed { [weak self] error in
                guard error == nil, let self else {
                    try? handle.close()
                    connection.cancel()
                    return
                }

                self.lKgydtQgUHomrPglhtcN(
                    handle: handle,
                    offset: offset + UInt64(data.count),
                    remaining: remaining - UInt64(data.count),
                    on: connection
                )
            }
        )
    }
}
