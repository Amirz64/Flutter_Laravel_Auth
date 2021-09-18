<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;


class DeleteController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function __invoke(Request $request)
    {
         $rules = [
            
            'username' => 'required',
            'password' => 'required|min:8',
            

        ];


        $validation = Validator::make($request->all(),$rules);

        if ($validation->fails()) {
            return response($validation->errors(),404);
        } 



         $user = User::where('username',$request->username)->first();

           

            if (!$user || !Hash::check($request->password,$user->password)) {


                $response = array(

                    'error' => 'failed',

                );

                return response($response,404);
            } else {
                $result = $user->delete();

                if ($result) {

                    $user->tokens()->delete();

                    return response([

                        'status' => 'success',

                    ],200);
                }

            }






    }

    public function deleteToken(Request $request){

    $user = User::where('username',$request->username)->first();
    

    if (!$user) {

        return response([
            'error' => 'failed'
        ],404);
    }


    $user->tokens()->delete();

  

        return response([
            'message' => 'success',
        ],200);
        
    // }


    }
}
