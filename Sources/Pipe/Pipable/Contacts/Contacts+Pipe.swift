//  Copyright © 2020-2022 Alex Kozin
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created by Alex Kozin
//  2022 Alex Kozin
//

import Contacts

extension CNContactStore: Constructable {
    
    static func | (piped: Any?, type: CNContactStore.Type) -> Self {
        Self()
    }
    
}

extension CNContact: Expectable {

    static func produce<T>(with: Any?, on pipe: Pipe, expecting: Event<T>) {        
        let source = with as? CNContactStore ?? pipe.get()
        let keys: [CNKeyDescriptor] = pipe.get() ?? []

        source.requestAccess(for: .contacts) { granted, error in
            guard granted else {
                return
            }
            
            let request = CNContactFetchRequest(keysToFetch: keys)
            request.predicate = with as? NSPredicate ?? pipe.get()
            do {
                try source.enumerateContacts(with: request) { contact, stop in
                    pipe.put(contact)
                }
            } catch {
                print(error)
            }
        }
    }
    
}
