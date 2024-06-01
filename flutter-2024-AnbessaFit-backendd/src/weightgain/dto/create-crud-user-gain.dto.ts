import { IsInt, IsNotEmpty, IsDateString } from 'class-validator';

export class CreateCrudUserGainDto {
  @IsNotEmpty()
  @IsDateString()
  startingdate: Date;

  @IsNotEmpty()
  @IsDateString()
  duedate: Date;

  @IsInt()
  weightGoal: number;

  @IsInt()
  calorieGoal: number;

  @IsInt()
  calorie: number;

  @IsInt()
  weight: number;
}
