<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class LoginController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function __invoke(Request $request)
    {
       
        $rules = array(

            'username' => 'required',
            'password' => 'required|min:8'

        );

        $loginValidation = Validator::make($request->all(),$rules);


        if ($loginValidation->fails()) {
            
            return response($loginValidation->errors(),404);

        }

        


            $user = User::where('username',$request->username)->first();

           

            if (!$user || !Hash::check($request->password,$user->password)) {


                $response = array(

                    'error' => 'Failed to login, please enter correct credential(s)',

                );

                return response($response,404);
            }

            $user->tokens()->delete();

            $token = $user->createToken($request->username)->plainTextToken;


            return response([

                'username' => $user->username,
                'email' => $user->email,
                'token' => $token,


            ],202);

        






    }
}
