<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UpdateController extends Controller
{
   
    public function changePassword(Request $request) {

        $rules = [


            'username' => 'required',
            'oldPassword' => 'required|min:8',
            'newPassword' => 'required|min:8',

        ];


        $validation = Validator::make($request->all(),$rules);

        if ($validation->fails()) {
            return response($validation->errors(),404);
        } 

        $user = User::where('username',$request->username)->first();

        if (!$user || !Hash::check($request->oldPassword,$user->password)){

            $response = [
                'error' => 'password is not correct',
            ];

            return response($response,404);

        } else {

            // $userModel = new User;

            // $userModel->username = $user->email;

            // $ema

            // $userModel->password = Hash::make($request->newPassword);

            // $result = $userModel->save();

            $result = User::where('username',$request->username)->update([
                'password' => Hash::make($request->newPassword),
            ]);

            if ($result) {
                return response(
                    [
                        'message' => 'success'

                    ],200
                );
            }

        }

        




        




    }





}
