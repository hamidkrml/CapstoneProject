//
//  File.swift
//  BitirmeProjesi
//
//  Created by hamid on 03.01.25.
//
import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
class LoginFirbase{

    @Published var user1: FirebaseAuth.User?
    
    static let shared = LoginFirbase()
    
    init() {
        self.user1 = Auth.auth().currentUser
    }
    
      
    func login(email:String, password:String)async throws{
        
        
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.user1 = result.user
        }catch{
            throw error
        }
        
    }
    
    func createUser(email:String,password:String,Kboyu:String,Kceki:String,Kad:String,Ksoyad:String)async throws{
        do{
            let resut = try await Auth.auth().createUser(withEmail: email, password: password)
            self.user1 = resut.user
            await uploadUserData(uid: resut.user.uid,Kboyu: Kboyu,Kceki: Kceki,Kad: Kad,Ksoyad: Ksoyad)
        }catch{
            throw error
        }
    }
    
    func uploadUserData(uid:String,Kboyu:String,Kceki:String,Kad:String,Ksoyad:String)async{
        let user = User(id: uid,ad: Kad,soyad: Ksoyad,boy: Kboyu, ceki: Kboyu)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else{return}
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
    
    func loadUserData()async throws{}
    
    func signout(){
        /// firbase kullanci adindan dusecek
        try? Auth.auth().signOut()
        DispatchQueue.main.async {
            self.user1 = nil
        }
    }
    
    
}
