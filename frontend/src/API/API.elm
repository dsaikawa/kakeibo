module API.API exposing (..)

import Http
import Json.Decode exposing (Decoder, field, int, list, map, map2, maybe, string)


getCategories : (Result Http.Error GetCategoriesResponse -> msg) -> String -> Cmd msg
getCategories msg idToken =
    Http.request
        { method = "GET"
        , headers =
            [ Http.header "Content-Type" "application/json"
            ]
        , url = "https://script.google.com/macros/s/AKfycbxo2s76FzqE2yg8IwvuGWMpgPf--K4obkfrYiCDuyE4Wut5vGIfdYmn8RbUNz0k-8h_/exec?idToken=" ++ idToken
        , expect = Http.expectJson msg categoriesDecoder
        , body = Http.emptyBody
        , timeout = Nothing
        , tracker = Nothing
        }


categoriesDecoder : Decoder GetCategoriesResponse
categoriesDecoder =
    map2 GetCategoriesResponse
        (field "status" int)
        (maybe (field "categories" (list string)))


type alias GetCategoriesResponse =
    { status : Int, categories : Maybe (List String) }
