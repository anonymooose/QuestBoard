
[1mFrom:[0m /home/james/code/Thorgold/QuestBoard/app/controllers/surveys_controller.rb @ line 45 SurveysController#update:

    [1;34m19[0m: [32mdef[0m [1;34mupdate[0m
    [1;34m20[0m:   @survey = [1;34;4mSurvey[0m.find(params[[33m:id[0m])
    [1;34m21[0m:   @event = @survey.event
    [1;34m22[0m:   [32mif[0m current_user.host != @event.host
    [1;34m23[0m:     attendance = survey_params[[33m:attended[0m] == [31m[1;31m'[0m[31mtrue[1;31m'[0m[31m[0m
    [1;34m24[0m:     attendance ? @survey.vote = [1;34;4mPlayer[0m.find(survey_params[[33m:vote[0m].to_i) : @survey.vote = [1;34m0[0m
    [1;34m25[0m:     [32mif[0m attendance
    [1;34m26[0m:       determine_change!
    [1;34m27[0m:       message = [31m[1;31m"[0m[31mThanks for answering! Here's #{@event.coins}[0m[31m coins and #{@event.experience}[0m[31m xp![1;31m"[0m[31m[0m
    [1;34m28[0m:     [32melse[0m
    [1;34m29[0m:       current_user.coins += [1;34m1[0m
    [1;34m30[0m:       current_user.players.where([31m[1;31m'[0m[31mevent_id = ?[1;31m'[0m[31m[0m, @event.id)[[1;34m0[0m].destroy
    [1;34m31[0m:       error_check!
    [1;34m32[0m:       message = [31m[1;31m"[0m[31mThanks for being honest! Here's 1 coin![1;31m"[0m[31m[0m
    [1;34m33[0m:     [32mend[0m
    [1;34m34[0m:   [32melse[0m
    [1;34m35[0m:     survey_params[[33m:host_attendance[0m].drop([1;34m1[0m).each [32mdo[0m |survey_id|
    [1;34m36[0m:       [1;34;4mSurvey[0m.find(survey_id.to_i).update([35mvote_id[0m: survey_params[[33m:host_win[0m].to_i)
    [1;34m37[0m:     [32mend[0m
    [1;34m38[0m:     @survey.host_win = [1;34;4mPlayer[0m.find(survey_params[[33m:host_win[0m].to_i)
    [1;34m39[0m:     determine_change!
    [1;34m40[0m:     message = [31m[1;31m"[0m[31mThanks for hosting. Here's #{@event.coins}[0m[31m coins and #{@event.experience}[0m[31m xp![1;31m"[0m[31m[0m
    [1;34m41[0m:   [32mend[0m
    [1;34m42[0m:   flash[[33m:notice[0m] = message
    [1;34m43[0m:   redirect_to surveys_path
    [1;34m44[0m:   binding.pry
 => [1;34m45[0m: [32mend[0m

