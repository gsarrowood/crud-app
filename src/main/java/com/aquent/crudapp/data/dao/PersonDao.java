package com.aquent.crudapp.data.dao;

import com.aquent.crudapp.domain.Person;
import java.util.List;

/**
 * Operations on the "person" table.
 */
public interface PersonDao {

    /**
     * Retrieves all of the person records.
     *
     * @return list of person records
     */
    List<Person> listPeople();

    /**
     * Retrieves all of the person records for a specific client.
     *
     * @return list of person records with the specified client.
     */
    List<Person> listPeopleByClient(Integer clientId);
	
	/**
	 * syncs selected persons with the current persons for the current
	 * client id.  i.e. ones that are associated with this client but
	 * are not in the selectedPersonList have their clientid set to -1.
	 * Ones that are not associated with this client but are on the 
	 * selectedPersonList have their clientid set to the passed in
	 * clientId.
	 * @param clientId
	 * @param selectedPersonIdList 
	 */
	void syncPeopleForClient( Integer clientId, List<Integer> selectedPersonIdList);
	
    /**
     * Creates a new person record.
     *
     * @param person the values to save
     * @return the new person ID
     */
    Integer createPerson(Person person);

    /**
     * Retrieves a person record by ID.
     *
     * @param id the person ID
     * @return the person record
     */
    Person readPerson(Integer id);

    /**
     * Updates an existing person record.
     *
     * @param person the new values to save
     */
    void updatePerson(Person person);

    /**
     * Deletes a person record by ID.
     *
     * @param id the person ID
     */
    void deletePerson(Integer id);
}
