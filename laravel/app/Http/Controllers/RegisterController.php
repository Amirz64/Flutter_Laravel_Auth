<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class RegisterController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function __invoke(Request $request)
    {

        
        $ip = $request->ip();

        // Use as bool
        $ipRestrict = User::where('ip',$ip)->exists();

        //parameters rules
        $rules = array(



            'username' => 'required|unique:users,username',
            'email' => 'required|unique:users,email|email',
            'password' => 'required|min:8|confirmed',

        );

        // Validate the request
        $registerValidation = Validator::make($request->all(),$rules);


        // if validation failed
        if ($registerValidation->fails()) {

             //Show errors
            return response($registerValidation->errors(),404);
        } 

        // if validation not failed 
        

            // if ip not available
            if(!$ipRestrict){

                // create new user in database

      
                $user = new User;

                $user->username = $request->username;

                $user->email = $request->email;

                $user->password = Hash::make($request->password);

                $user->ip = $ip;

                $result = $user->save();



                if ($result) {

                    $newUser = $user->where('username',$request->username)->first();
                    $token = $newUser->createToken($request->username)->plainTextToken;

                    

                    $response = [

                        'message' => 'user succesfully created',
                        'username' => $request->username,
                        'email' => $request->email,
                        'token' => $token,

                    ];

                    return response($response,201);
                }

            }

            return response([

                'message' => 'ip is available',

            ],404);



   
    }



}
